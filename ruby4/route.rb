class Route # Класс Route (Маршрут):

  attr_accessor :stations

  def initialize (from, to) # Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
    @stations = [from, to]
  end

  def add_station(station) # Может добавлять промежуточную станцию в список
    stations.insert(-2, station)
    puts "К маршруту #{self.name} добавлена станция #{station.name}"
  end

  def delete_station(station) # Может удалять промежуточную станцию из списка
    if [stations.first, stations.last].include?(station)
      puts "Начальную и конечую станцию нельзя удалить"
    else
      stations.delete(station)
      puts "Из маршрута #{self.name} удалена станция #{station.name}"
    end
  end

  def show_stations # Может выводить список всех станций по-порядку от начальной до конечной
    puts "В маршрут #{self.name} входят станции: "
    stations.each{|station| puts " #{station.name}" }
  end

  def name
    stations.first.name + " - " + stations.last.name
  end

end
