module MenuCar
  def call_menu_car
    show_menu_car
    choice = gets.to_i
    return if choice.zero?
    call_car_menu_handler(choice)
  end

  def show_menu_car
     puts 'Выберите пункт меню, 0 для выхода'
     puts '1 - Добавить вагон к поезду'
     puts '2 - Убрать вагон из поезда'
     puts '3 - Занять место/объем в вагоне'
     puts '4 - Вывести список вагонов у поезда'
     puts '5 - Возврат в предыдущее меню'
  end

  private

  def call_car_menu_handler(choice)
    case choice
    when 1 then add_car_to_train
    when 2 then delete_car_from_train
    when 3 then call_take_volume
    when 4 then list_of_cars
    when 5 then call_menu_train
    end
  end

  def add_car_to_train
    loop do
      train = select_train
      break if train.nil?
      car = get_car(train)
      return if train.nil? || car.nil?
      train.add_car(car)
    end
  end

  def get_car(train)
    case train
    when PassengerTrain then create_passenger_car
    when CargoTrain then create_cargo_car
    end
  end

  def delete_car_from_train
    train = select_train
    return if train.nil?
    train.delete_car
  end

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

  def call_take_volume
    car = select_car
    if car.class == PassengerCar
      car.set_take_volume
    else
      volume = get_take_volume
      car.set_ake_volume(volume)
    end

  end

  def select_car
    cars = list_of_cars
    puts 'Введите порядковый номер вагона или 0 для выхода'
    choice = gets.to_i
    return if choice.zero?
    cars[choice - 1]
  end

  def get_take_volume
    puts 'Введите занимаемый в вагоне объем'
  end

  def list_of_cars
    number = 0
    train = select_train
    if train.class == PassengerTrain
      train.each_car { |car| puts "Номер вагона #{number += 1},
      тип вагона: пассажирский,
      кол-во свободных мест #{car.free_volume},
      кол-во занятых мест #{car.take_volume}" }
    else
      train.each_car { |car| puts "Номер вагона #{number += 1},
      тип вагона: грузовой,
      свободный объем #{car.free_volume},
      занятый объем #{car.take_volume}" }
    end
  end


end
