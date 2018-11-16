class Train
  attr_accessor :count_car, :speed, :type, :current_station
  attr_reader :route

  def initialize(number, type, count_car)
    @number = number
    @type = type
    @count_car = count_car
    @speed = 0
  end

  def gain_speed(speed)
    @speed = speed
  end

  def decrease_speed(delta)
    if speed - delta > 0
      @speed -= delta
    else
      @speed = 0
    end
  end

  def add_car
    @count_car += 1 if @speed == 0
  end

  def delete_car
    @count_car -= 1 if @speed == 0 && @count_car > 1
  end

  def add_route(route)
    @route = route
    @current_station = 0
    @route.stations[@current_station].add_train(self)
  end

  def forward_motion
    if next_station
      @route.stations[@current_station].departure_train(self)
      @route.stations[next_station].add_train(self)
      @current_station += 1
    end
  end

  def backward_motion
    if previous_station
      @route.stations[@current_station].departure_train(self)
      @route.stations[previous_station].add_train(self)
      @current_station -= 1
    end
  end

  def previous_station
    previous_station = current_station - 1 if @current_station != 0
  end

  def next_station
    next_station = @current_station + 1 if @current_station != @route.stations.length - 1
  end
end
