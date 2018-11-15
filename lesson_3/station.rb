class Station
  attr_accessor :trains
  attr_accessor :train
  attr_accessor :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train if train.current_station = self
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def show_train_by_type
    cargo_trains = @trains.select { |train| train.type == :cargo }
    count_cargo_train = cargo_trains.length
    puts 'Список грузовых поездов на станции:'
    show_train cargo_trains

    passenger_trains = @trains.select { |train| train.type == :passenger }
    count_passenger_train = passenger_trains.length
    puts 'Список пассажирских поездов на станции:'
    show_train passenger_trains
    puts "Кол-во грузовых поездов #{count_cargo_train}, кол-во пассажирских #{count_passenger_train}"
  end

  def show_train(trains)
    trains.each { |train| puts train.number }
  end
end
