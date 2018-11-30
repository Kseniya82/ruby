module MenuCar

  def create_passenger_car
    count_place = get_count_place
    PassengerCar.new(count_place)
  end

  def get_count_place
    puts 'Введите число мест в вагоне'
    gets.to_i
  end

  def create_cargo_car
    volume = get_volume
    CargoCar.new(volume)
  end

  def get_volume
    puts 'Введите объем вагона'
    gets.to_i
  end

end
