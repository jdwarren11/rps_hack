class RPS::Game

  attr_reader :m_id, :p_id, :id
  attr_accessor :p_move

  def initialize(m_id, p1_id, p2_id, p1_move=nil, p2_move=nil, id=nil)
    @m_id = m_id
    @p1_id = p1_id
    @p2_id = p2_id
    @p1_move = p1_move
    @p2_move = p2_move
    @id = id
  end

  def create!
    id_from_db = RPS.orm.create_game(@m_id)
    @id = id_from_db
    self
  end

  def make_move!(id, player_id, p_move)
    if player_id == @p1_id
      RPS.orm.update_p1_move(@id, @p1_move)
    elsif player_id == @p2_id
      RPS.orm.update_move(@id, @p2_move)
    end
  end
end