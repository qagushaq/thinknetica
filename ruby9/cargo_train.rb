class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super(number, 'cargo')
  end

  def attach_car(car)
    raise 'К грузовому поезду можно прицеплять только грузовые вагоны' unless car.instance_of?(CargoCar)

    super(car)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
