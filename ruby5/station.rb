class Station

  include InstanceCounter

  @@stations = []

  attr_reader :name

  def initialize(name)
    @name = name
    @@stations << self
    @trains = []
    register_instance
  end

  def self.all
    @@stations
  end

  def get_train(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    puts "Из станции #{name} отправился #{train.number} поезд "
  end

  def show_trains(type = nil)
    if type
      puts "Номер(а) поездов на станции #{name} типа #{type}: "
      @trains.each { |train| puts train.number if train.type == type }
    else
      puts "Поезда на станции #{name}: "
      @trains.each { |train| puts train.number }
    end
  end

end
