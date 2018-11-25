require 'byebug'
require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :trains, :name
  @@stations = []
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end
end
