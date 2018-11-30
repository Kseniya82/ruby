require_relative 'route'

module MenuRoute
  def call_menu_route
    show_menu_route
    choice = gets.to_i
    return if choice.zero?
    call_route_menu_handler(choice)
  end


  def show_menu_route
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать маршрут'
    puts '2 - Добаивть станцию к маршруту'
    puts '3 - Удалить станцию и маршрута'
    puts '4 - Присволить маршрут поезду'
    puts '5 - Вернуться  в предыдущее меню'
  end

  def call_route_menu_handler(choice)
    case choice
    when 1 then create_route
    when 2 then add_station_in_route
    when 3 then delete_station_from_route
    when 4 then add_route_at_train
    when 5 then run
    end
  end

  def create_route
    start_station = select_station
    end_station = select_station
    @routed << Route.new(start_station, end_station)
    call_menu_route if return?
  end

  def select_station
    show_stations(@stations)
    puts 'Выберите порядковый номер станции или 0 для выхода'
    choice = gets.to_i
    return if choice.zero?
    @stations[choice - 1]
  end

  def add_station_in_route
    route = select_route
    station = select_station
    return if route.nil? || station.nil?
    route.add_station(station)
    call_menu_route if return?
  end


  def delete_station_from_route
    route = select_route
    station = select_station_in_route(route)
    return if route.nil? || station.nil?
    route.delete_station(station)
    call_menu_route if return?
  end

  def add_route_at_train
    train = select_train
    route = select_route
    return if route.nil? || train.nil?
    train.add_route(route)
    call_menu_route if return?
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

  def show_routed
    @routed.each_with_index do |route, index|
      puts "номер п/п #{index + 1}, список станций:"
      route.stations.each { |station| puts station.name }
    end
  end
end
