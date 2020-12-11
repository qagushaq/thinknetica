class Station # Класс Station (Станция):

  attr_reader :name

  def initialize(name) # Имеет название, которое указывается при ее создании
    @name = name
    @trains = []
  end

  def get_train(train) # Может принимать поезда (по одному за раз)
    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train) # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
    @trains.delete(train)
    puts "Из станции #{name} отправился #{train.number} поезд "
  end

  def show_trains(type = nil)
    if type
      puts "Номер(а) поездов на станции #{name} типа #{type}: "
      @trains.each{|train| puts train.number if train.type == type}
    else
      puts "Поезда на станции #{name}: "
      @trains.each{|train| puts train.number}
    end
  end

end
