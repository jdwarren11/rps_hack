class RPS::Match

  def initialize(p1_id, p2_id, result, id=nil)
    @p1_id = p1_id
    @p2_id = p2_id
    @result = :pending
    @id = id
  end

  def create!
    
  end

  
end