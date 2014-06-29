module RPS
  class PlayGame

    def self.run(match_id,player_id,move)
      # params => {:user_id => 23, :match_id => 1, :game_id => 1, :move => 'rock'}
      # check for match
      # enter move in db
      # check that 2 moves have been played
      # return hash with result

      # if game exists and 2 moves have been played
      # get game from database and compare moves
      # database_hash = {game_id, match_id, p1_id, p2_id, p1_move, p2_move}
      

      open_game = RPS.orm.find_open_game(match_id)


      if open_game
        game = RPS::Game.new(open_game['m_id'],
          open_game['p1_id'],open_game['p2_id'],
          open_game['p1_move'],open_game['p2_move'],open_game['id'] )

        game.make_move!(game.id,player_id,move)

      else

        match_info = RPS::orm.find_match_by_id(match_id)
        
        game = RPS::Game.new(match_info['id'],match_info['p1_id'],
          match_info['p2_id'],nil,nil,nil)

        game.create!
        game.make_move!(game.id,player_id,move)
      end

      Player1_counter = 0
      Player2_counter = 0


      find = RPS.orm.get_game_by_match_id(match_id)

      find.each do |game|

        if game['p1_move'] == game['p2_move']
        
        elsif game['p1_move'] == 'rock'
          if game['p2_move'] == 'paper'
            
            count_win(game['p2_id'],Player1_counter,
              Player2_counter,match)
          else
            
            count_win(game['p1_id'],Player1_counter,
              Player2_counter,match)
          end
        elsif game['p1_move'] == 'paper'
          if game['p2_move'] == 'scissors'
            count_win(game['p2_id'],Player1_counter,
              Player2_counter,match)
          else
            count_win(game['p1_id'])
          end
        elsif game['p1_move'] == 'scissors'
          if game['p2_move'] == 'rock'
            count_win(game['p2_id'],Player1_counter,
              Player2_counter,match)
          else
            count_win(game['p2_id'],Player1_counter,
              Player2_counter,match)
          end
        else
          'something went wrong'
        end

        if Player1_counter >= 3
          match.winner = match.p1_id
          match.update!
          return match.p1_id
        elsif Player2_counter >= 3
          match.winner = match.p2_id
          match.update!
          return match.p2_id
        end     
      end
      
      return false



    end
  end
end