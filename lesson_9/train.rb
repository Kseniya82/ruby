require_relative 'instance_counter'
require_relative 'company_producer'
require_relative 'accessors'
require_relative 'validation'

class Train
  include CompanyProducer
  include InstanceCounter
  extend Accessors
  include Validation

  NUMBER_FORMAT = /^[a-zа-яё\d]{3}\-?[a-zа-яё\d]{2}$/i.freeze

  attr_reader :speed, :route, :cars

  attr_accessor_with_history :number

  strong_attr_accessor :number, String

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

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
end
