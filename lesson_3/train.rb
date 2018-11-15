class Train
  attr_accessor :count_car
  attr_accessor :speed
  attr_accessor :current_station
  attr_accessor :route
  attr_accessor :type

  def initialize(number, type, count_car)
    @number = number
    @type = type
    @count_car = count_car
    @speed = 0
  end

  def gain_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_car
    @count_car += 1 if @speed == 0
  end

  def delete_car
    @count_car -= 1 if @speed == 0
  end

  def add_route(route)
    @route = route
    @current_station = route.stations[0]
  end

  def forward_motion
    @current_station = next_station
  end

  def backward_motion
    @current_station = last_station
  end

  def last_station
    last_station = if @route.stations.index(current_station) != 0
                     @route.stations[@route.stations.index(current_station) - 1]
                   else
                     current_station
                   end
  end

  def next_station
    next_station = if @route.stations.index(@current_station) != -1
                     @route.stations[@route.stations.index(@current_station) + 1]
                   else
                     current_station
                   end
  end
end
