class RPS::Game

  def initialize(m_id, p1_id, p2_id, p1_move =nil, p2_move=nil, winner=nil id=nil)
    @m_id = m_id
    @p1_id = p1_id
    @p2_id = p2_id
    @p1_move = p1_move
    @p2_move = p2_move
    @winner = winner
    @id = id
  end

  def create!
    id_from_db = RPS.orm.create_game(@mid)
  end

  def make_move(p_id, p_move)
    if p_id == p1_id
      p1_move = p_move
    elsif p_id == p2_id
      p2_move = p_move
    end

  


  end

  def calculate_result
    if @winnner == nil && p1_move != nil && p2_move != nil
      if @p1_move == @p2_move
        @winnner = 'tie'
      elsif @p1_move == 'rock'
        if @p2_move == 'paper'
          @winnner = @p2_id
        else
          @winnner = @p1_id
        end
      elsif @p1_move == 'paper'
        if @p2_move == 'scissors'
          @winnner = @p2_id
        else
          @winner = @p1_id
        end
      elsif @p1_move == 'scissors'
        if @p2_move == 'rock'
          @winner = @p2_id
        else
          @winner = @p1_id
        end
      else
        'something went wrong'
      end
    end
    # TM.orm.update_game()
  end
  
end