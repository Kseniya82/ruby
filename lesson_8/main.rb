require_relative 'menu_train'
require_relative 'menu_route'
require_relative 'menu_station'
require_relative 'menu_car'

class Main
  attr_reader :trains, :routed, :stations

  include MenuTrain
  include MenuRoute
  include MenuStation
  include MenuCar

  MAIN_MENU = [
    { handler: :call_menu_station, title: 'Станции' },
    { handler: :call_menu_train, title: 'Поезда' },
    { handler: :call_menu_route, title: 'Маршруты' },
    { handler: :call_menu_car, title: 'Выгоны' }
  ].freeze

  MENU_STATION = [
    { handler: :create_station, title: 'Создать станцию' },
    { handler: :call_show_station, title: 'Показать список станций' },
    { handler: :show_train_on_station, title: 'Показать список поездов на станции' }
  ].freeze

  MENU_ROUTE = [
    { handler: :create_route, title: 'Создать маршрут' },
    { handler: :add_station_in_route, title: 'Добаивть станцию к маршруту' },
    { handler: :delete_station_from_route, title: 'Удалить станцию из маршрута' },
    { handler: :add_route_at_train, title: 'Присволить маршрут поезду' }
  ].freeze

  MENU_CAR = [
    { handler: :add_car_to_train, title: 'Добавить вагон к поезду' },
    { handler: :delete_car_from_train, title: 'Убрать вагон из поезда' },
    { handler: :call_take_volume, title: 'Занять место/объем в вагоне' },
    { handler: :list_of_cars, title: 'Вывести список вагонов у поезда' }
  ].freeze

  MENU_TRAIN = [
    { handler: :call_create_train, title: 'Создать поезд' },
    { handler: :train_motion, title: 'Движение поезда' }
  ].freeze

  def initialize
    @routed = []
    @stations = []
    @trains = []
  end

  def run
    call_menu(MAIN_MENU)
  end

  private

  def show_menu_items(menu)
    puts 'Выберите пункт меню или 0 для выхода'
    index = 1
    menu.each do |menu_item|
      puts "#{index} - #{menu_item[:title]}"
      index += 1
    end
  end

  def call_menu(menu)
    loop do
      show_menu_items(menu)
      choice = gets.to_i
      break if choice.zero?

      selected_item = menu[choice - 1]
      send(selected_item[:handler]) if selected_item
    end
  end

  def call_menu_station
    call_menu(MENU_STATION)
  end

  def call_menu_train
    call_menu(MENU_TRAIN)
  end

  def call_menu_route
    call_menu(MENU_ROUTE)
  end

  def call_menu_car
    call_menu(MENU_CAR)
  end
end
