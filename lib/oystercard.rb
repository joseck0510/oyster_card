class Oystercard

  BALANCE_LIMIT = 90
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    fail "Maximum balance of #{BALANCE_LIMIT} would be exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Your balance is under #{MINIMUM_FARE} pound, please top up first" if balance < MINIMUM_FARE
    @entry_station = station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
