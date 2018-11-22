class CargoTrain < Train
  def add_car(car)
    cars << car if car.is_a? CargoCar
  end
end
