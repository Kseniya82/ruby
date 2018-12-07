require_relative 'instance_counter'
require_relative 'validation'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  EQUALS_STATION_ERROR = 'Начальная и конечная станция совпадают'.freeze

  attr_reader :stations

  validate :last_station, :presence
  validate :first_station, :presence
  validate :last_station, :type, Station
  validate :first_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate_no_equals
    validate!

    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  protected

  def validate_no_equals
    raise EQUALS_STATION_ERROR if @first_station == @last_station
  end
end
