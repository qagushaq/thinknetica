class Route # Класс Route (Маршрут):

  attr_accessor :stations, :from, :to

  def initialize (from, to) # Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
    @stations = [from, to]
    puts "Создан маршрут из #{from.name} в #{to.name}"
  end

  def add_station(station) # Может добавлять промежуточную станцию в список
    self.stations.insert(-2, station)
    puts "К маршруту #{stations.first.name} - #{stations.last.name} добавлена станция #{station.name}"
  end

  def delete_station(station) # Может удалять промежуточную станцию из списка
    if [stations.first, stations.last].include?(station)
      puts "Начальную и конечую станцию нельзя удалить"
    else
      self.stations.delete(station)
      puts "Из маршрута #{stations.first.name} - #{stations.last.name} удалена станция #{station.name}"
    end
  end

  def show_stations # Может выводить список всех станций по-порядку от начальной до конечной
    puts "В маршрут #{stations.first.name} - #{stations.last.name} входят станции: "
    stations.each{|station| puts " #{station.name}" }
  end

end
