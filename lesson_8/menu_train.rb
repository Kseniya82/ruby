require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'menu_car'

module MenuTrain
  private

  def call_train_menu_handler(choice)
    send(MenuTrain.private_instance_methods[choice])
  end

  def call_create_train
    loop do
      begin
        train = create_train
        break if train.nil?

        @trains << train
        show_success_train_create(train) if train.valid?
      rescue RuntimeError => e
        puts e.message
        retry
      end
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

  def create_train
    number = train_number
    return if number == '0'

    type = train_type
    return if number.nil? || type.nil?

    type.new(number)
  end

  def train_number
    puts 'Введите номер поезда или 0 для выхода'
    gets.chomp
  end

  def train_type
    puts 'Введите тип поезда: 1- пассажирский, 2 - грузовой'
    case gets.to_i
    when 1 then PassengerTrain
    when 2 then CargoTrain
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
