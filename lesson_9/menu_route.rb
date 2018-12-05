require_relative 'route'

module MenuRoute
  MENU_ROUTE = [
    { handler: :create_route, title: 'Создать маршрут' },
    { handler: :add_station_in_route, title: 'Добавить станцию к маршруту' },
    { handler: :delete_station_from_route, title: 'Удалить станцию из маршрута' },
    { handler: :add_route_at_train, title: 'Присволить маршрут поезду' }
  ].freeze

  private

  def call_menu_route
    call_menu(MENU_ROUTE)
  end

  def create_route
    start_station = select_station
    end_station = select_station
    @routed << Route.new(start_station, end_station)
  end

  def add_station_in_route
    loop do
      route = select_route
      break if route.nil?

      station = select_station
      return if route.nil? || station.nil?

      route.add_station(station)
    end
  end

  def delete_station_from_route
    route = select_route
    station = select_station_in_route(route)
    return if route.nil? || station.nil?

    route.delete_station(station)
  end

  def add_route_at_train
    loop do
      train = select_train
      break if train.nil?

      route = select_route
      return if route.nil? || train.nil?

      train.add_route(route)
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

  def show_routed
    @routed.each_with_index do |route, index|
      puts "номер п/п #{index + 1}, список станций:"
      route.stations.each { |station| puts station.name }
    end
  end
end
