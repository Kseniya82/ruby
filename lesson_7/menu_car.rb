module MenuCar
  def call_menu_car
    loop do
      show_menu_car
      choice = gets.to_i
      break if choice.zero?
      call_car_menu_handler(choice)
    end
  end

  def show_menu_car
     puts 'Выберите пункт меню, 0 для выхода'
     puts '1 - Добавить вагон к поезду'
     puts '2 - Убрать вагон из поезда'
     puts '3 - Занять место/объем в вагоне'
     puts '4 - Вывести список вагонов у поезда'
  end

  private

  def call_car_menu_handler(choice)
    case choice
    when 1 then add_car_to_train
    when 2 then delete_car_from_train
    when 3 then call_take_volume
    when 4 then list_of_cars
    end
  end

  def add_car_to_train
    loop do
      train = select_train
      break if train.nil?
      car = get_car(train)
      return if car.nil?
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
    loop do
      car = select_car
      break if car.nil?
      if car.is_a?(CargoCar)
        volume = get_volume
        take_volume = car.take_volume(volume)
        show_take_error if take_volume.nil?
      else
        take_volume =  car.take_volume
        show_take_error if take_volume.nil?
      end
    end
  end

  def show_take_error
    puts 'Нет достаточного кол-ва свободного места'
  end

  def select_car
    train = select_train
    return if train.nil?
    show_train_cars(train)
    choice = gets.to_i
    return if choice.zero?
    train.cars[choice - 1]
  end

  def list_of_cars
    loop do
      train = select_train
      break unless train
      show_train_cars(train)
    end
  end

  def show_train_cars(train)
    number = 1
    train.each_car do |car|
      puts "Номер вагона #{number}"
      car_info = train.is_a?(PassengerTrain) ? passenger_car_info(car) : cargo_car_info(car)
      puts car_info
      number += 1
    end
  end

  def passenger_car_info(car)
    car_info = ['тип вагона: пассажирский']
    car_info << "кол-во свободных мест #{car.free_volume}"
    car_info << "кол-во занятых мест #{car.taken_volume}"
    car_info.join(', ')
  end

  def cargo_car_info(car)
    car_info = ['тип вагона: грузовой']
    car_info << "свободный объем #{car.free_volume}"
    car_info << "занятый объем #{car.taken_volume}"
    car_info.join(', ')
  end
end
