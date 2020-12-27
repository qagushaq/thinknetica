class PassengerCar < Car
  attr_reader :filled

  def initialize(count_seats)
    @count_seats = count_seats
    @filled = 0
  end

  def take_seat
    raise 'Все места заняты.' if @filled > @count_seats

    @filled += 1
  end

  def occupied
    @filled
  end

  def free
    @count_seats - @filled
  end
end
