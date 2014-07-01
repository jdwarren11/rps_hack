module RPS
  class Match
    attr_reader :p1_id, :id, :p2_id
    attr_accessor :winner, :p1_id, :id, :p2_id

    def initialize(p1_id, p2_id=nil, id=nil, winner=nil)
      @p1_id = p1_id
      @p2_id = p2_id
      @winner = winner
      @id = id
    end

    def create!
      id_from_db = RPS.orm.create_match(@p1_id)
      @id = id_from_db
      self
    end

    def save_winner!
        RPS.orm.update_winner(@id, @winner)
    end

    # def update!
    #   RPS.orm.update_match(@p1_id, @p2_id, @id, @winner)
    # end

    
  end
end