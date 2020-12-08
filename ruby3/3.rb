class Station   #Класс Station (Станция):

  attr_reader :name, :trains

  def initialize(name) #Имеет название, которое указывается при ее создании
    @name = name
    @trains = []
    puts "Cтанция: #{name}"
  end

  def get_train(train)   #Может принимать поезда (по одному за раз)
    trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def show_trains(type)  #Может возвращать список всех поездов на станции, находящиеся в текущий момент
    if type = 1   #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
      puts "Номера поездов на станции #{name} типа грузовые: "
      trains.each{|train| puts train.number if train.type == 1}
    else
      puts "Номера поездов на станции #{name} типа пассажирские "
      trains.each{|train| puts train.number if train.type == 0}
    end
  end

  def send_train(train)   #Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
    trains.delete(train)
    train.station = nil
    puts "Из станции #{name} отправился #{train.number} поезд "
  end

end

class Route   #Класс Route (Маршрут):

  attr_accessor :stations, :from, :to

  def initialize (from, to)   #Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
    @stations = [from, to]
    puts "Создан маршрут из #{from.name} в #{to.name}"
  end

  def add_station(station)   #Может добавлять промежуточную станцию в список
    self.stations.insert(-2, station)
    puts "К маршруту #{stations.first.name} - #{stations.last.name} добавлена станция #{station.name}"
  end

  def delete_station(station) #Может удалять промежуточную станцию из списка
    if [stations.first, stations.last].include?(station)
      puts "Начальную и конечую станцию нельзя удалить"
    else
      self.stations.delete(station)
      puts "Из маршрута #{stations.first.name} - #{stations.last.name} удалена станция #{station.name}"
    end
  end

  def show_stations #Может выводить список всех станций по-порядку от начальной до конечной
    puts "В маршрут #{stations.first.name} - #{stations.last.name} входят станции: "
    stations.each{|station| puts " #{station.name}" }
  end

end


class Train #Класс Train (Поезд):

  attr_accessor :speed, :number, :car_count, :route, :station
  attr_reader :type

  def initialize(number, type, count_cars) #Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
    @number = number
    @type = type
    @count_cars = count_cars
    @speed = 0
    puts "Создан поезд № #{number}, тип - #{type}, количество вагонов - #{count_cars}"
  end

  def run #Может набирать скорость
      self.speed += 10
  end

  def stop #Может тормозить (сбрасывать скорость до нуля)
    self.speed = 0
  end

  def currnet_speed  #Может возвращать текущую скорость
    puts "Текущая скорость: #{speed}"
  end

  def get_count_cars #Может возвращать количество вагонов
    return count_cars
  end

  def attach_car #Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
    if speed.zero? #Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
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

  def get_route(route)#Может принимать маршрут следования (объект класса Route).При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    self.route = route
    puts "У поезда #{number} следующий маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def stations_info #Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
    if route.nil?
      puts "Маршрут не задан"
    else
      station_index = route.stations.index(station)
      puts "Поезд на станции - #{station.name}."
      puts "Предыдущая станция - #{route.stations[station_index - 1].name}." if station_index != 0
      puts "Следующая станция - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end

  def move_to(station)#Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
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

station_minsk = Station.new("Минск")
station_brest = Station.new("Брест")
station_bitebsk = Station.new("Витебск")
station_grodno = Station.new("Гродно")
station_gomel = Station.new("Гомель")

route_minsk_brest = Route.new(station_minsk, station_brest)
route_minsk_brest.add_station(station_bitebsk)
route_minsk_brest.add_station(station_gomel)
route_minsk_brest.show_stations

route_minsk_brest.delete_station(station_minsk)
route_minsk_brest.delete_station(station_brest)
route_minsk_brest.delete_station(station_bitebsk)
route_minsk_brest.show_stations

train1 = Train.new(1, 1, 150)
train2 = Train.new(2, 0, 16)

train1.get_route(route_minsk_brest)
train1.move_to(station_brest)
train1.move_to(station_gomel)


station_gomel.show_trains
