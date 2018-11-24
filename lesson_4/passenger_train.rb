class PassengerTrain < Train
  def attachable_car?(car)
    car.is_a?(PassengerCar)
  end
end
