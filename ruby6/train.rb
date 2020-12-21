class Train

  include ManufacturingCompany
  include InstanceCounter

  attr_accessor :speed, :number, :route, :station, :cars
  attr_reader :type

  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
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
    if speed.zero?
      self.cars << car
    puts "К поезду №#{number} прицепили вагон"
    else
      puts 'Поезд движется, нельзя прицеплять вагоны'
    end
  end

  def detach_car(car)
    if !cars.include?(car)
    puts 'Нечего отцеплять'
    elsif speed.zero?
      self.cars.delete(car)
      puts "От поезда №#{number} отцепили вагон"
    else
      puts 'Поезд движется, нельзя отцеплять вагоны'
    end
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
    if route.nil?
      puts 'Маршрут не задан'
    else
      current_station
      next_station
      pred_station
    end
  end

  def move_to(station)
    if route.nil?
    puts 'Нужно задать маршрут.'
    elsif @station == station
      puts "Поезд #{@number} уже на станции #{@station.name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "#{station.name} не входит в маршрут поезда №#{number}"
    end
  end

end
