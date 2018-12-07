require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  extend Accessors
  include Validation

  attr_reader :trains
  attr_accessor_with_history :name

  validate :name, :presence

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    self.name = name
    validate!

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

  def each_train
    @trains.each { |train| yield(train) }
  end
end
