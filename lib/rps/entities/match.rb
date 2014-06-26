class RPS::Match
  attr_reader :p1_id, :p2_id, :id
  attr_accessor :winner

  def initialize(p1_id, p2_id, winner=:pending, id=nil)
    @p1_id = p1_id
    @p2_id = p2_id
    @winner = winner
    @id = id
  end

  def create!

  end

  
end