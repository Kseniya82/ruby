require_relative 'instance_counter'
require_relative 'company_producer'

class Train
  include CompanyProducer
  include InstanceCounter

  attr_reader :speed, :route, :cars, :number

  NUMBER_FORMAT = /^[a-zа-яё\d]{3}\-?[a-zа-яё\d]{2}$/i.freeze
  NUMBER_FORMAT_ERROR = 'Неверный формат номера'.freeze
  EMPTY_NUMBER_ERROR = 'Введен пустой номер'.freeze

  @@trains = {}

  def self.all
    @@trains.values
  end

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @cars = []
    @speed = 0
    validate!
    register_instance
    @@trains[number] = self
  end

  def each_car
    @cars.each { |car| yield(car) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def increase_speed(delta)
    @speed += delta
  end

  def decrease_speed(delta)
    if speed - delta > 0
      @speed -= delta
    else
      @speed = 0
    end
  end

  def add_car(car)
    return unless @speed.zero?
    return unless attachable_car?(car)

    cars << car
  end

  def delete_car
    cars.delete_at(-1)
  end

  def add_route(route)
    @route = route
    @current_station = 0
    current_station.add_train(self)
  end

  def forward_motion
    return unless next_station

    current_station.departure_train(self)
    next_station.add_train(self)
    @current_station += 1
  end

  def backward_motion
    return unless previous_station

    current_station.departure_train(self)
    previous_station.add_train(self)
    @current_station -= 1
  end

  def previous_station
    return unless @current_station > 0

    @route.stations[@current_station - 1]
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def current_station
    @route.stations[@current_station]
  end

  protected

  def validate!
    raise EMPTY_NUMBER_ERROR if @number.nil?
    raise NUMBER_FORMAT_ERROR if @number !~ NUMBER_FORMAT
  end
end
