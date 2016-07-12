class Oystercard

  BALANCE_LIMIT = 90
  DEFAULT_BALANCE = 0

  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    fail "Maximum balance of #{BALANCE_LIMIT} would be exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

end
