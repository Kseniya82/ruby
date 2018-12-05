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
    { handler: :call_menu_car, title: 'Вгоны' }
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
end
