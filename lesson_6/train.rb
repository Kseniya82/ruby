require_relative 'instance_counter'
require_relative 'company_producer'

class Train
  include CompanyProducer
  include InstanceCounter

  attr_reader :speed, :route, :cars, :number

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/
  ERROR_NUMBER_FORMAT = 'Неверный формат номера'
  ERROR_EMPTY_NUMBER = 'Введен пустой номер'

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

  def valid?
    validate!
    true
  rescue
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
    return unless @speed == 0
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
    if next_station
      current_station.departure_train(self)
      next_station.add_train(self)
      @current_station += 1
    end
  end

  def backward_motion
    if previous_station
      current_station.departure_train(self)
      previous_station.add_train(self)
      @current_station -= 1
    end
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
    raise ERROR_EMPTY_NUMBER if @number.nil?
    raise ERROR_NUMBER_FORMAT if @number !~ NUMBER_FORMAT
  end
end
