require_relative 'menu_train'
require_relative 'menu_route'
require_relative 'menu_station'

class Main
  attr_reader :trains, :routed, :stations

  include MenuTrain
  include MenuRoute
  include MenuStation

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

end
