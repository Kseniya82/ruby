require_relative 'car'

class PassengerCar < Car
  def take_volume
    super(1)
  end
end
