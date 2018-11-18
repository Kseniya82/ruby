require_relative 'car.rb'
require_relative 'cargo_car.rb'
require_relative 'passenger_car.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'

@stations = []
@trains = []
@routed = []

choice = 1
while choice != 0 do
  user_interface
  choice = gets.to_i
  user_choice(choice)  #  не видит этого метода
end

def user_interface
  puts 'Выберите пункт меню, 0 - для выхода:'
  puts '1 - Создать станцию'
  puts '2 - Создать поезд'
  puts '3 - Создать маршрут'
  puts '4 - Назначить маршрут поезду'
  puts '5 - Добавить вагоны к поезду'
  puts '6 - Отцепить вагоны от поезда'
  puts '7 - Переместить поезд по маршруту'
  puts '8 - Просмотреть список станций и список поездов на станции'
end

def user_choice(choice)
  case choice
  when 1 then create_station
  when 2 then case_create_train
  when 3 then create_route
  when 4 then add_route_at_train
  when 5 then add_car_to_train
  when 6 then delete_car_from_train
  when 7 then train_motion
  when 8 then show_station_and_train_on_station
  end
end

private
#напрямую к методам из пользовательнского интерфейса лучше не обращаться

def create_station
  puts 'Введите имя станции или стоп для выхода'
  name_station = gets.chomp
  while name_station.upcase != 'СТОП' do
    station = Station.new(name_station)
    @stations << station
    puts 'Введите имя станции или стоп для выхода'
    name_station = gets.chomp
  end
end

def case_create_train
  puts 'Введите номер поезда или стоп для выхоа'
  number_train = gets.chomp
  while name_station.upcase != 'СТОП' do
    create_train(number_train)
    puts 'Введите номер поезда или стоп для выхоа'
    number_train = gets.chomp
  end
end

def create_train(number_train)
  puts 'Введите тип поезда: 1- пассажирский, 2 - грузовой'
  case gets.to_i
    when 1 then train = PassengerTrain.new(number_train)
    when 2 then train = CargoTrain.new(number_train)
  else
    puts 'Ошибка вввода'
  end
  @trains << train
end

def create_route
  puts 'Введите имена начальной станции'
  station_first_name = gets.chomp
  while station_first_name.upcase != 'СТОП'
    station_last_name = gets.chomp
    route = Route.new(st1,st2) if st1 != st2
    @routed << route
    puts 'Введите имена начальной станции'
    station_first_name = gets.chomp
  end
end

def add_route_at_train
  puts 'Введите порядковый номер поезда, которому хотите добавить маршрут'
  show_trains
  index_train = gets.to_i - 1
  puts 'Введите порядковый номер добавляемого маршрута'
  show_route
  index_route = gets.to_i - 1
  @trains[index_train].add_route(@routed[index_route])
end

def add_car_to_train
  puts 'Введите порядковый номер поезда, которому хотите добавить вагоны'
  show_trains
  index_train = gets.to_i - 1
  if trains[index_train].type = :passenger
    trains[index_train].cars << PassengerCar.new
  else
    trains[index_train].cars << CargoCar.new
  end
end

def delete_car_from_train
  puts 'Введите порядковый номер поезда, которому хотите удалить вагоны'
  show_trains
  index_train = gets.to_i -1
  trains.cars.delote_at(-1)
end

def train_motion
  puts 'Введите порядковый номер поезда'
  show_trains
  index_train = gets.to_i - 1
  puts 'Введите направление движения'
  puts '1 -вперед, 2 - назад'
  choice_motion = gets.to_i
  case choice_motion
  when 1 then trains[index_train].forward_motion
  when 2 then rains[index_train].backward_motion
end

def show_station_and_train_on_station
  puts 'Список станций'
  show_stations
  puts 'Выберите станцию для отображения списка поездов на ней'
  indew_station = gets.to_i - 1
  show_train_on_station(indew_station)
end

def show_train
  trains.each_with_index do |traiin, index|
    puts "номер п/п #{index + 1}, номер поезда #{train.number}, тип поезда #{train.type}"
  end
end

def show_routed
  routed.each_with_index do |route, index|
    puts "номер п/п #{index + 1}, список станций #{route}"
  end
end

def show_stations
  stations.each_with_index do |station, index|
    puts "номер п/п #{index + 1}, название станции: #{station.name}"
  end
end

def show_train_on_station(index)
  @stations[index].trains.each do |train|
    puts "Номер поезда #{train.number}, тип поезда #{train.type}"
  end
end
