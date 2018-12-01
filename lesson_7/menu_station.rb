require_relative 'station'

module MenuStation

  def call_menu_station
    show_menu_station
    choice = gets.to_i
    return if choice.zero?
    call_station_menu_handler(choice)
  end

  def show_menu_station
     puts 'Выберите пункт меню, 0 для выхода'
     puts '1 - Создать станцию'
     puts '2 - Показать список станций'
     puts '3 - Показать список поездов на станции'
     puts '4 - Возврат в предыдущее меню'
   end

  private

  def call_station_menu_handler(choice)
    case choice
    when 1 then create_station
    when 2 then show_stations(@stations)
    when 3 then show_train_on_station
    when 4 then run
    end
  end

  def create_station
    puts 'Введите имя станции или 0 для выхода'
    name_station = gets.chomp
    return if name_station == '0'
    station = Station.new(name_station)
    @stations << station
    call_menu_station if return?
  end

  def show_train_on_station
    puts 'Список станций'
    show_stations(@stations)
    puts 'Выберите станцию для отображения списка поездов на ней'
    indew_station = gets.to_i - 1
    show_train(indew_station)
  end

  def show_train(indew_station)
    station = @stations[indew_station]
    station.each_train { |train| puts "Номер поезда #{train.number},
    тип поезда:#{train.class},
    кол-во вагонов #{train.cars.length}" }
  end

  def show_stations(stations)
    stations.each_with_index do |station, index|
      puts "номер п/п #{index + 1}, название станции: #{station.name}"
    end
  end
end
