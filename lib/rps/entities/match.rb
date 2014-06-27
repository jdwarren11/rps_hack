module RPS
  class Match
    attr_reader :p1_id, :id, :p2_id
    attr_accessor :winner

    def initialize(p1_id, winner=:pending,p2_id=nil, id=nil)
      @p1_id = p1_id
      @winner = winner
      @id = id
    end

    # we need to assign a user to a match
    # check first to see if there is an open match
    # if not, we need to create a new match
    # should match have a total number of games played?????
    def create!
      id_from_db = RPS.orm.create_match(@p1_id)
      @id = id_from_db
      self
    end

    
  end
end