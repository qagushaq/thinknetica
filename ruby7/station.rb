class Station

  include InstanceCounter
  include Validate

  @@stations = []

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def iterate_trains(&block)
    raise "На станции нет поездов" if @trains.empty?
    @trains.each { |train| yield(train) }
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

protected

  def validate!
    raise "Вы не задали название станции, попробуйте еще раз!" if name.empty?
  end

end
