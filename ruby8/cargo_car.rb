class CargoCar < Car
  attr_reader :filled

  def initialize(volume)
    @volume = volume
    @filled = 0
  end

  def load(volume)
    raise 'Нет места' if volume + @filled > @volume

    @filled += volume
  end

  def free
    @volume - @filled
  end
end
