class PassengerCar < Car
  attr_reader :count_free_place, :count_take_place

  def initialize(count_places)
    @count_place = count_places
    @count_free_place = count_places
    @count_take_place = 0
  end

  def take_place
    @count_free_place -= 1
    @count_take_place += 1
  end

end
