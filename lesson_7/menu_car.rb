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
    train = select_train
    return call_menu_car if train.nil?
    car = get_car(train)
    return call_menu_car if car.nil?
    train.add_car(car)
    add_car_to_train  if retry?
    call_menu_car
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
    call_menu_car
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
    puts 'Введите объем'
    gets.to_i
  end

  def call_take_volume
    car = select_car
    volume = car.is_a?(CargoCar) ? get_volume : 1
    car.take_volume(volume)
    call_take_volume  if retry?
    call_menu_car
  end

  def select_car
    train = select_train
    show_train_cars(train)
    choice = gets.to_i
    return if choice.zero?
    train.cars[choice - 1]
  end

  def list_of_cars
    train = select_train
    show_train_cars(train)
    list_of_cars  if retry?
    call_menu_car
  end

  def show_train_cars(train)
    number = 0
    if train.class == PassengerTrain
      train.each_car { |car| puts "Номер вагона #{number += 1},
      тип вагона: пассажирский,
      кол-во свободных мест #{car.free_volume},
      кол-во занятых мест #{car.taken_volume}" }
    else
      train.each_car { |car| puts "Номер вагона #{number += 1},
      тип вагона: грузовой,
      свободный объем #{car.free_volume},
      занятый объем #{car.taken_volume}" }
    end
  end
end
