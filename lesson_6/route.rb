require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  ERROR_NO_EXIST_STATION = 'Одна или более станций не существует'
  ERROR_EQUALS_STATION = 'Начальная и конечная станция совпадают'

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
  rescue
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
    raise ERROR_NO_EXIST_STATION if @first_station.is_a?(Station) || @last_station.is_a?(Station)
    raise ERROR_EQUALS_STATION if @first_station.is_a?(Station) == @last_station.is_a?(Station)
  end

end
