module RPS
  class CheckWinner

    def count_win(player,c1,c2,match)

      if player == match.p2_id
        c2 +=1
      else
        c1 +=1
      end


    end

    def self.run(match_id)

      match_db = find_match_by_id(match_id)

      match = RPS::Match.new(match_db['p1_id'],
        match_db['winner'],match_db['p2_id'],match_db['id'])

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
          return match.p1_id
        elsif Player2_counter >= 3
          return match.p2_id
        end     
      end
      
      return false

  end
end