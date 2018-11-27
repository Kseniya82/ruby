require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  ERROR_EMPTY_NAME ='Введено пустое имя'

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

  protected

  def validate!
    raise ERROR_EMPTY_NAME if @name.nil?
  end
end
