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
    puts '4 - Вагоны'
  end

  def call_main_menu_handler(choice)
    case choice
    when 1 then call_menu_station
    when 2 then call_menu_train
    when 3 then call_menu_route
    when 4 then call_menu_car
    end
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

  def retry?
    show_retry
    choice = gets.to_i
    if choice == 1
      true
    else
      false
    end
  end

  def show_retry
    puts 'Желаете повторить?'
    puts '1 - да, 0- нет'
  end

end
