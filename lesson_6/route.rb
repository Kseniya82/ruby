require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
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
    raise "Имя не может быть пустым" if first_station.nil? || lasr_station.nil?
    raise 'Неверный ввод первой станции' if @stations[0].!include? Station.stations
    raise 'Неверный ввод последней станции'if @stations[1].!include? Station.stations
  end

end
