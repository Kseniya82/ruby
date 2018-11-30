class CargoCar < Car
  attr_reader :take_volume, :free_volume

  def initialize(volume)
    @cvolume = volume
    @free_volume = volume
    @take_volume = 0
  end

  def self.take_volume(volume)
    @free_volune -= volume
    @take_volume += volume
  end
end
