require_relative 'station'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_accessor :balance, :journey_history_array

  def initialize
    @balance = 0
    @journey_history_array = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    sufficient_balance_check?
    @entry_station = station #  journey.new(entry_station: station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station #
    @journey = {entry_station: entry_station, exit_station: exit_station}
    self.journey_history_array << journey
    journey
    self.entry_station = nil
  end

def in_journey?
  !!entry_station
end

private

attr_accessor :exit_station, :journey, :entry_station

  def deduct(amount)
    self.balance -= amount
  end

  def sufficient_balance_check?
    raise "insufficient funds" if balance < MINIMUM_FARE
  end
end
