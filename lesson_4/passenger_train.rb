class PassengerTrain < Train
  def add_car(car)
    cars << car if car.is_a? PassengerCar
  end
end
