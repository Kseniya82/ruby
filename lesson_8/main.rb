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

  def call_main_menu_handler(choice)
    send(self.class.private_instance_methods[choice + 1])
  end

  def call_menu_station
    show_menu_station
    choice = gets.to_i
    return if choice.zero?

    call_station_menu_handler(choice)
  end

  def call_menu_train
    loop do
      show_menu_train
      choice = gets.to_i
      break if choice.zero?

      call_train_menu_handler(choice)
    end
  end

  def call_menu_route
    loop do
      show_menu_route
      choice = gets.to_i
      break if choice.zero?

      call_route_menu_handler(choice)
    end
  end

  def call_menu_car
    loop do
      show_menu_car
      choice = gets.to_i
      break if choice.zero?

      call_car_menu_handler(choice)
    end
  end

  def show_menu_car
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Добавить вагон к поезду'
    puts '2 - Убрать вагон из поезда'
    puts '3 - Занять место/объем в вагоне'
    puts '4 - Вывести список вагонов у поезда'
  end

  def show_menu_route
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать маршрут'
    puts '2 - Добаивть станцию к маршруту'
    puts '3 - Удалить станцию и маршрута'
    puts '4 - Присволить маршрут поезду'
  end

  def show_menu_station
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать станцию'
    puts '2 - Показать список станций'
    puts '3 - Показать список поездов на станции'
  end

  def show_menu_train
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать поезд'
    puts '2 - Движение поезда'
  end

  def show_main_menu
    puts 'Выберите интересующий Вас объект, 0 - для выхода:'
    puts '1 - Станции'
    puts '2 - Поезда'
    puts '3 - Маршруты'
    puts '4 - Вагоны'
  end

  def return?
    show_return
    choice = gets.to_i
    choice == 1
  end

  def show_return
    puts 'Желаете вернуться в предыдущее меню?'
    puts '1 - да, 0- нет'
  end
end
