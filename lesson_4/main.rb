require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
class Main
  attr_reader :trains, :routed, :stations
  def initialize
    @routed = []
    @stations = []
    @trains = []
  end

  def run
    loop do
      show_main_menu
      choice = gets.to_i
      break if choice.zero?
      call_main_menu_handler(choice)
    end
  end

  def show_main_menu
    puts 'Выберите пункт меню, 0 - для выхода:'
    puts '1 - Создать станцию'
    puts '2 - Создать поезд'
    puts '3 - Создать маршрут'
    puts '4 - Назначить маршрут поезду'
    puts '5 - Добавить вагоны к поезду'
    puts '6 - Отцепить вагоны от поезда'
    puts '7 - Переместить поезд по маршруту'
    puts '8 - Просмотреть список станций и список поездов на станции'
  end

  def call_main_menu_handler(choice)
    case choice
    when 1 then create_station
    when 2 then case_create_train
    when 3 then show_menu_create_route
    when 4 then add_route_at_train
    when 5 then add_car_to_train
    when 6 then delete_car_from_train
    when 7 then train_motion
    when 8 then show_station_and_train_on_station
    end
  end

private
#напрямую к методам из пользовательнского интерфейса лучше не обращаться

  def create_station
    loop do
      puts 'Введите имя станции или 0 для выхода'
      name_station = gets.chomp
      break if name_station == '0'
      station = Station.new(name_station)
      @stations << station
    end
  end

  def case_create_train
    loop do
      puts 'Введите номер поезда или 0 для выхоа'
      number_train = gets.chomp
      break if number_train == '0'
      create_train(number_train)
    end
  end

  def create_train(number_train)
    puts 'Введите тип поезда: 1- пассажирский, 2 - грузовой'
    case gets.to_i
      when 1 then train = PassengerTrain.new(number_train)
      when 2 then train = CargoTrain.new(number_train)
    else
      puts 'Ошибка вввода'
    end
    @trains << train
  end

  def show_menu_create_route
    loop do
      puts 'Выберите пункт меню, 0 для выхода'
      puts '1 - Создать маршрут'
      puts '2 - Добаивть станцию к маршруту'
      puts '3 - Удалить станцию и маршрута'
      choice_menu_route = gets.to_i
      break if choice_menu_route.zero?
      call_menu_create_route_handler(choice_menu_route)
    end
  end

  def call_menu_create_route_handler (choice)
    case choice
    when 1 then create_route
    when 2 then add_station_in_route
    when 3 then delete_station_from_route
    end
  end

  def create_route
    loop do
      puts 'Выберите начальную станцию'
      start_station = select_station
      break if !start_station
      puts 'Выберите конечную станцию'
      end_station = select_station
      return if start_station.nil? || end_station.nil?
      return if start_station == end_station
      @routed << Route.new(start_station, end_station)
    end
  end

  def add_station_in_route
    route = select_route
    station = select_station
    route.add_station(station)
  end

  def delete_station_from_route
    route = select_route
    station = select_station
    route.delete_station(station)
  end

  def add_route_at_train
    train = select_train
    route = select_route
    train.add_route(route)
  end

  def add_car_to_train
    loop do
      break if !select_train
      train = select_train
      if train.type == :passenger
        car = PassengerCar.new
      else
        car = CargoCar.new
      end
      train.add_car(car)
    end
  end

  def delete_car_from_train
    train = select_train
    train.delete_car
  end

  def train_motion
    train = select_train
    choice_motion = select_motion
    case choice_motion
    when 1 then train.forward_motion
    when 2 then train.backward_motion
    end
  end

  def select_station
    show_stations
    puts "Выберите порядковый номер станции или 0 для выхода"
    choice = gets.to_i
    return if choice.zero?
    @stations[choice - 1]
  end

  def select_train
    puts 'Введите порядковый номер поезда или 0 для выхода'
    show_trains
    choice = gets.to_i
    return if choice.zero?
    @trains[choice - 1]
  end

  def select_route
    puts 'Введите порядковый номер маршрута'
    show_routed
    @routed[gets.to_i - 1]
  end
  def select_motion
    puts 'Введите направление движения'
    puts '1 -вперед, 2 - назад'
    gets.to_i
  end

  def show_station_and_train_on_station
    puts 'Список станций'
    show_stations
    puts 'Выберите станцию для отображения списка поездов на ней'
    indew_station = gets.to_i - 1
    show_train_on_station(indew_station)
  end

  def show_trains
    @trains.each_with_index do |train, index|
      puts "номер п/п #{index + 1}, номер поезда #{train.number}, тип поезда #{train.type}"
    end
  end

  def show_routed
    @routed.each_with_index do |route, index|
      puts "номер п/п #{index + 1}, список станций:"
      route.stations.each { |station| puts station.name}
    end
  end

  def show_stations
    @stations.each_with_index do |station, index|
      puts "номер п/п #{index + 1}, название станции: #{station.name}"
    end
  end

  def show_train_on_station(index)
    @stations[index].trains.each do |train|
      puts "Номер поезда #{train.number}, тип поезда #{train.type}"
    end
  end
end
