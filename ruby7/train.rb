class Train

  include ManufacturingCompany
  include InstanceCounter
  include Validate

  attr_accessor :speed, :number, :route, :station, :cars
  attr_reader :type

  @@trains = {}

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def run(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def attach_car(car)
    raise 'Поезд движется, нельзя прицеплять вагоны' unless speed.zero?
    self.cars << car
    puts "К поезду №#{number} прицепили вагон"
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def detach_car(car)
    raise 'Нечего отцеплять' if !cars.include?(car)
    raise 'Поезд движется, нельзя прицеплять вагоны' unless speed.zero?
      self.cars.delete(car)
      puts "От поезда №#{number} отцепили вагон"
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def get_route(route)
    self.route = route
    move_to(route.stations.first)
    puts "У поезда #{number} следующий маршрут: #{route.name}"
    station.get_train(self)
  end

  def current_station
    puts "Поезд №#{number} на станции - #{station.name}."
  end

  def next_station
    station_index = route.stations.index(station)
    route.stations[station_index + 1].name if station_index != route.stations.size - 1
  end

  def pred_station
    station_index = route.stations.index(station)
    route.stations[station_index - 1].name if station_index != 0
  end

  def stations_info
    raise "Маршрут не задан" if route.nil?
      current_station
      next_station
      pred_station
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def move_to(station)
    raise 'Нужно задать маршрут.' if route.nil?
    raise "Поезд #{@number} уже на станции #{@station.name}" if @station == station
    raise "#{station.name} не входит в маршрут поезда №#{number}" unless route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  private

  def validate!
    raise 'Номер поезда не соответствует шаблону (ххххх или ххх-хх)' if number !~ NUMBER_FORMAT
  end

end
