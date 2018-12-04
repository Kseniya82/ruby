require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  NO_EXIST_STATION_ERROR = 'Одна или более станций не существует'.freeze
  EQUALS_STATION_ERROR = 'Начальная и конечная станция совпадают'.freeze

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = [first_station, last_station]
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  protected

  def validate!
    raise NO_EXIST_STATION_ERROR if @first_station.nil? || @last_station.nil?
    raise EQUALS_STATION_ERROR if @first_station == @last_station
  end
end
