module RPS
  class PlayGame

    def self.run(params)
      # params => {:user_id => 23, :match_id => 1, :game_id => 1, :move => 'rock'}
      # check for match
      # enter move in db
      # check that 2 moves have been played
      # return hash with result

      player = []
      game = RPS.orm.get_open_game_by_match_id(params[:match_id])
      if game.nil?
        players = RPS.orm.get_player(params[:match_id])
        game = Game.new(params[:match_id], players[0].id,players[1].id,nil,nil,nil,nil)
        RPS.orm.save_game(game) #seting game id on object
      end

      # if game exists and 2 moves have been played
      # get game from database and compare moves
      # database_hash = {game_id, match_id, p1_id, p2_id, p1_move, p2_move}
      moves = RPS.orm.get_game 
      if moves.p1_move == moves.p2_move
        RPS.orm.update_match_result('tie')
      elsif moves.p1_move == 'rock'
        if moves.p2_move == 'paper'
          RPS.orm.update_match_result(p2_id)
        else
          RPS.orm.update_match_result(p1_id)
        end
      elsif moves.p1_move == 'paper'
        if moves.p2_move == 'scissors'
          RPS.orm.update_match_result(p2_id)
        else
          RPS.orm.update_match_result(p1_id)
        end
      elsif moves.p1_move == 'scissors'
        if moves.p2_move == 'rock'
          RPS.orm.update_match_result(p2_id)
        else
          RPS.orm.update_match_result(p1_id)
        end
      else
        'something went wrong'
      end
      




    end
  end
end