class RPS::Match
  attr_reader :p1_id, :p2_id, :id
  attr_accessor :winner

  def initialize(player_id, winner=:pending, id=nil)
    @player_id = player_id
    @winner = winner
    @id = id
  end

  # we need to assign a user to a match
  # check first to see if there is an open match
  # if not, we need to create a new match
  # should match have a total number of games played?????
  def create!

  end

  
end