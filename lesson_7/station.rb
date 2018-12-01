require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  EMPTY_NAME_ERROR ='Введено пустое имя'

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise EMPTY_NAME_ERROR if @name.nil?
  end
end
