require_relative 'menu_train'
require_relative 'route'
require_relative 'station'

class Main
  attr_reader :trains, :routed, :stations

  include MenuTrain

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

  private

  # напрямую к методам из пользовательнского интерфейса лучше не обращаться
  def show_main_menu
    puts 'Выберите интересующий Вас объект, 0 - для выхода:'
    puts '1 - Станции'
    puts '2 - Поезда'
    puts '3 - Маршруты'
  end

  def call_main_menu_handler(choice)
    case choice
    when 1 then call_menu_station
    when 2 then call_menu_train
    when 3 then call_menu_route
    end
  end

  def create_station
    loop do
      puts 'Введите имя станции или 0 для выхода'
      name_station = gets.chomp
      break if name_station == '0'

      station = Station.new(name_station)
      @stations << station
    end
  end



  def show_menu_create_route
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать маршрут'
    puts '2 - Добаивть станцию к маршруту'
    puts '3 - Удалить станцию и маршрута'
  end

  def call_menu_create_route_handler
    loop do
      show_menu_create_route
      choice_menu_route = gets.to_i
      break if choice_menu_route.zero?

      case choice_menu_route
      when 1 then create_route
      when 2 then add_station_in_route
      when 3 then delete_station_from_route
      end
    end
  end

  def create_route
    start_station = select_station
    end_station = select_station
    return if start_station.nil? || end_station.nil?
    return if start_station == end_station

    @routed << Route.new(start_station, end_station)
  end

  def add_station_in_route
    route = select_route
    station = select_station
    return if route.nil? || station.nil?

    route.add_station(station)
  end

  def delete_station_from_route
    route = select_route
    station = select_station_in_route(route)
    return if route.nil? || station.nil?

    route.delete_station(station)
  end

  def add_route_at_train
    train = select_train
    route = select_route
    return if route.nil? || train.nil?

    train.add_route(route)
  end

  def train_motion
    train = select_train
    choice_motion = select_motion
    return if train.nil? || train.route.nil?

    case choice_motion
    when 1 then train.forward_motion
    when 2 then train.backward_motion
    end
  end

  def select_station
    show_stations(@stations)
    puts 'Выберите порядковый номер станции или 0 для выхода'
    choice = gets.to_i
    return if choice.zero?

    @stations[choice - 1]
  end

  def select_station_in_route(route)
    show_stations(route.stations)
    puts 'Выберите порядковый номер станции или 0 для выхода'
    choice = gets.to_i
    return if choice.zero?

    route.stations[choice - 1]
  end


  def select_route
    puts 'Введите порядковый номер маршрута'
    show_routed
    index = gets.to_i
    return if index.zero?

    @routed[index - 1]
  end

  def select_motion
    puts 'Введите направление движения'
    puts '1 -вперед, 2 - назад'
    gets.to_i
  end

  def show_station_and_train_on_station
    puts 'Список станций'
    show_stations(@stations)
    puts 'Выберите станцию для отображения списка поездов на ней'
    indew_station = gets.to_i - 1
    show_train_on_station(indew_station)
  end



  def show_routed
    @routed.each_with_index do |route, index|
      puts "номер п/п #{index + 1}, список станций:"
      route.stations.each { |station| puts station.name }
    end
  end

  def show_stations(stations)
    stations.each_with_index do |station, index|
      puts "номер п/п #{index + 1}, название станции: #{station.name}"
    end
  end

  def show_train_on_station(index)
    @stations[index].trains.each do |train|
      puts "Номер поезда #{train.number}"
    end
  end
end
