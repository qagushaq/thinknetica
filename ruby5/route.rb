class Route

  include InstanceCounter

  attr_accessor :stations

  def initialize (from, to)
    @stations = [from, to]
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
    puts "К маршруту #{self.name} добавлена станция #{station.name}"
  end

  def delete_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Начальную и конечую станцию нельзя удалить"
    else
      stations.delete(station)
      puts "Из маршрута #{self.name} удалена станция #{station.name}"
    end
  end

  def show_stations
    puts "В маршрут #{self.name} входят станции: "
    stations.each{ |station| puts " #{station.name}" }
  end

  def name
    stations.first.name + " - " + stations.last.name
  end

end
