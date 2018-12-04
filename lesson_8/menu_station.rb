require_relative 'station'

module MenuStation
  private

  def create_station
    loop do
      puts 'Введите имя станции или 0 для выхода'
      name_station = gets.chomp
      break if name_station == '0'

      station = Station.new(name_station)
      @stations << station
    end
  end

  def call_show_station
    show_stations(@stations)
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
    station.each_train do |train|
      puts "Номер поезда #{train.number},
    тип поезда:#{train.class},
    кол-во вагонов #{train.cars.length}"
    end
  end

  def show_stations(stations)
    stations.each_with_index do |station, index|
      puts "номер п/п #{index + 1}, название станции: #{station.name}"
    end
  end
end
