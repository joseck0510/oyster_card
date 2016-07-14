class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_accessor :entry_station, :exit_station

  def initialize (entry_station:)
    @entry_station = entry_station
    @exit_station
  end
  def complete?
    !!exit_station
  end

  def fare
    if complete?
      MINIMUM_FARE
    else
      PENALTY_FARE
    end 
  end

  def finish(station)
    self.exit_station = station
    self


  end
end
