class Station # Класс Station (Станция):

  attr_reader :name, :trains

  def initialize(name) # Имеет название, которое указывается при ее создании
    @name = name
    @trains = []
    puts "Cтанция: #{name}"
  end

  def get_train(train) # Может принимать поезда (по одному за раз)
    trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def show_trains(type) # Может возвращать список всех поездов на станции, находящиеся в текущий момент
    if type == 1 # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
      puts "Номер(а) поездов на станции #{name} типа грузовые: "
      trains.each{|train| puts train.number if train.type == 1}
    else
      puts "Номер(а) поездов на станции #{name} типа пассажирские "
      trains.each{|train| puts train.number if train.type == 0}
    end
  end

  def send_train(train) # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
    trains.delete(train)
    train.station = nil
    puts "Из станции #{name} отправился #{train.number} поезд "
  end

end
