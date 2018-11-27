class CargoTrain < Train
  def attachable_car?(car)
    car.is_a?(CargoCar)
  end
end
