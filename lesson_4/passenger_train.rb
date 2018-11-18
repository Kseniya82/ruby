class PassengerTrain < Train
  def initialize(number)
    super
    @type = :cargo
  end
end
