class Train # Класс Train (Поезд):

  attr_accessor :speed, :number, :car_count, :route, :station # Может возвращать текущую скорость
  attr_reader :type

  def initialize(number, type, count_cars) # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
    @number = number
    @type = type
    @count_cars = count_cars
    @speed = 0
    puts "Создан поезд № #{number}, тип - #{type}, количество вагонов - #{count_cars}"
  end

  def run # Может набирать скорость
    self.speed += 10
  end

  def stop # Может тормозить (сбрасывать скорость до нуля)
    self.speed = 0
  end

  def get_count_cars # Может возвращать количество вагонов
    return count_cars
  end

  def attach_car # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
    if speed.zero? # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
      self.count_cars += 1
    puts "К поезду №#{number} прицепили вагон, общее количество вагонов: #{count_cars}."
    else
     puts "Поезд движется, нельзя прицеплять вагоны"
    end
  end

  def detach_car
  if count_cars.zero?
    puts "Нечего отцеплять"
    elsif speed.zero?
      self.count_cars -= 1
      puts "От поезда №#{number} отцепили вагон, общее количество вагонов: #{count_cars}."
    else
      puts "Поезд движется, нельзя отцеплять вагоны"
    end
  end

  def get_route(route) # Может принимать маршрут следования (объект класса Route).При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    self.route = route
    move_to(route.stations.first)
    puts "У поезда #{number} следующий маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def current_station
    puts "Поезд №#{number} на станции - #{station.name}."
  end

  def next_station
    station_index = route.stations.index(station)
    puts "Следующая станция поезда № #{number}  - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
  end

  def pred_station
    station_index = route.stations.index(station)
    puts "Предыдущая станция поезда № #{number}- #{route.stations[station_index - 1].name}." if station_index != 0
  end

  def stations_info # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
    if route.nil?
      puts "Маршрут не задан"
    else
      current_station
      next_station
      pred_station
    end
  end

  def move_to(station) # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
    if route.nil?
    puts "Нужно задать маршрут."
    elsif @station == station
      puts "Поезд #{@number} уже на станции #{@station.name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "#{station.name} не входит в маршрут поезда #{number}"
    end
  end

end
