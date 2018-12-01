require_relative 'company_producer'

class Car
  include CompanyProducer

  attr_reader :take_volume, :free_volume

  def initialize(volume)
    @volume = volume
    @take_volume = 0
  end

  def set_take_volume(volume)
    @take_volume += volume unless free_volume < 0
  end

  def free_volume
    @volume - @take_volume
  end

end
