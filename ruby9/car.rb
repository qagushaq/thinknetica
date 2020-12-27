class Car
  include ManufacturingCompany
  include InstanceCounter

  def initialize
    register_instance
  end
end
