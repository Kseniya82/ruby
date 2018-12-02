require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'menu_car'

module MenuTrain

  include MenuCar

 def call_menu_train
   loop do
     show_menu_train
     choice = gets.to_i
     break if choice.zero?
     call_train_menu_handler(choice)
   end
 end

 def show_menu_train
    puts 'Выберите пункт меню, 0 для выхода'
    puts '1 - Создать поезд'
    puts '2 - Движение поезда'
  end

  private

  def call_train_menu_handler(choice)
    case choice
    when 1 then create_train
    when 2 then train_motion
    end
  end

  def get_train_number
    puts 'Введите номер поезда или 0 для выхода'
    gets.chomp
  end

  def create_train
    loop do
      begin
        train_number = get_train_number
        break  if train_number == '0'
        train_type = get_train_type
        return if train_number.nil? || train_type.nil?
        train = train_type.new(train_number)
        @trains << train
      rescue RuntimeError => e
        puts e.message
        retry
      end
      show_success_train_create(train) if train.valid?
    end
  end

  def get_train_type
    puts 'Введите тип поезда: 1- пассажирский, 2 - грузовой'
    case gets.to_i
    when 1 then PassengerTrain
    when 2 then CargoTrain
    end
  end

  def train_motion
    train = select_train
    choice_motion = select_motion
    return if train.nil? || train.route.nil?
    case choice_motion
    when 1 then train.forward_motion
    when 2 then train.backward_motion
    end
  end

  def select_motion
    puts 'Введите направление движения'
    puts '1 -вперед, 2 - назад'
    gets.to_i
  end

  def select_train
    puts 'Введите порядковый номер поезда или 0 для выхода'
    show_trains
    choice = gets.to_i
    return if choice.zero?
    @trains[choice - 1]
  end

  def show_trains
    @trains.each_with_index do |train, index|
      puts "номер п/п #{index + 1}, номер поезда #{train.number}"
    end
  end

  def show_success_train_create(train)
    puts "Поезд номер #{train.number} типа #{train.class} успешно создан"
  end
end
