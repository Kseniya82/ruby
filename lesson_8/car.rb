require_relative 'company_producer'

class Car
  include CompanyProducer

  attr_reader :taken_volume

  def initialize(volume)
    @volume = volume
    @taken_volume = 0
  end

  def take_volume(volume)
    return if volume > free_volume

    @taken_volume += volume
  end

  def free_volume
    @volume - @taken_volume
  end
end
