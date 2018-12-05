require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter

  EQUALS_STATION_ERROR = 'Начальная и конечная станция совпадают'.freeze

  ttr_reader :stations

  valid :last_station, :presence
  valid :first_station, :presence
  valid :last_station, :type, Station
  valid :first_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate_no_equals
    return unless valid?

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
