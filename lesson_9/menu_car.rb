module MenuCar
  MENU_CAR = [
    { handler: :add_car_to_train, title: 'Добавить вагон к поезду' },
    { handler: :delete_car_from_train, title: 'Убрать вагон из поезда' },
    { handler: :call_take_volume, title: 'Занять место/объем в вагоне' },
    { handler: :list_of_cars, title: 'Вывести список вагонов у поезда' }
  ].freeze

  private

  def call_menu_car
    call_menu(MENU_CAR)
  end

  def add_car_to_train
    loop do
      train = select_train
      break if train.nil?

      car = car(train)
      return if car.nil?

      train.add_car(car)
    end
  end

  def delete_car_from_train
    train = select_train
    return if train.nil?

    train.delete_car
    call_menu_car
  end

  def call_take_volume
    loop do
      car = select_car
      break if car.nil?

      take_volume = if car.is_a?(CargoCar)
                      car.take_volume(volume)
                    else
                      car.take_volume
                    end
      show_take_error && take_volume.nil?
    end
  end

  def list_of_cars
    loop do
      train = select_train
      break unless train

      show_train_cars(train)
    end
  end

  def car(train)
    case train
    when PassengerTrain then create_passenger_car
    when CargoTrain then create_cargo_car
    end
  end

  def create_passenger_car
    PassengerCar.new(count_place)
  end

  def count_place
    puts 'Введите число мест в вагоне'
    gets.to_i
  end

  def create_cargo_car
    CargoCar.new(volume)
  end

  def volume
    puts 'Введите объем'
    gets.to_i
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

  def show_train_cars(train)
    number = 1
    train.each_car do |car|
      puts "Номер вагона #{number}"
      car_info = car.is_a?(CargoCar) ? cargo_car_info(car) : passenger_car_info(car)
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
