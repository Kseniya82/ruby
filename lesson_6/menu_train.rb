require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'

module MenuTrain

 def call_menu_train
   show_menu_train
   choice = gets.to_i
   return if choice.zero?
   call_train_menu_handler(choice)
 end

 def show_menu_train
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать поезд'
    puts '2 - Добавить вагон к поезду'
    puts '3 - Убрать вагон из поезда'
    puts '4 - Возврат в предыдущее меню'
  end

  def call_train_menu_handler(choice)
    case choice
    when 1 then create_train
    when 2 then add_car_to_train
    when 3 then delete_car_from_train
    when 4 then run
    end
  end

  def get_train_number
    puts 'Введите номер поезда или 0 для выхода'
    gets.chomp
  end

  def create_train
  begin
    train_number = get_train_number
    return  if train_number == '0'
    train_type = get_train_type
    return if train_number.nil? || train_type.nil?
    train = train_type.new(train_number)
    @trains << train
  rescue RuntimeError => e
    puts e.message
    retry
  end
    show_success_train_create(train) if train.valid?
    call_menu_train if return?
  end

  def return?
    show_return
    choice = gets.to_i
    if choice == 1
      true
    else
      false
    end
  end

  def show_return
    puts 'Желаете вернуться в предыдущее меню?'
    puts '1 - да, 0- нет'
  end

  def get_train_type
    puts 'Введите тип поезда: 1- пассажирский, 2 - грузовой'
    case gets.to_i
    when 1 then PassengerTrain
    when 2 then CargoTrain
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

  def get_train_car(train)
    case train
    when PassengerTrain then PassengerCar.new
    when CargoTrain then CargoCar.new
    end
  end

  def delete_car_from_train
    train = select_train
    return if train.nil?
    train.delete_car
  end

  def select_train
    puts 'Введите порядковый номер поезда или 0 для выхода'
    show_trains
    choice = gets.to_i
    return if choice.zero?
    @trains[choice - 1]
  end

  def show_trains
    @trains.each_with_index do |train, index|
      puts "номер п/п #{index + 1}, номер поезда #{train.number}"
    end
  end

  def show_success_train_create(train)
    puts "Поезд номер #{train.number} типа #{train.class} успешно создан"
  end
end
