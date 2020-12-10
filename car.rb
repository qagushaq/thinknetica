class Car

  attr_reader :current_rpm

  def initialize
    @current_rpm = 0
  end

  def start_engine
    start_engine if engine_stopped?
  end

  def engine_stopped?
    current_rpm.zero?
  end

  protected

  attr_writer :current_rpm

  def initial_rpm
    700
  end

  def start_engine
    self.current_rpm.zero = initial_rpm
  end

end

class Truck < Car
  def loading
  end

  protected

  def initial_rpm
    500
  end

end

class SportCar < Car

  def start_engine
    puts "cliiick"
    super
    puts "wroom"
  end

  protected

  def initial_rpm
    1000
  end
end
