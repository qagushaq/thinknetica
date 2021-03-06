class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super(number, 'passenger')
  end

  def attach_car(car)
    raise 'К пассажирскому поезду можно прицеплять только пассажирские вагоны' unless car.instance_of?(PassengerCar)

    super(car)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
