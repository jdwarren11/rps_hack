module RPS
  class PlayGame

    # params => {:user_id, :match_id, :move, }

    def self.run(params)

      match = RPS.orm.find_match_by_id( params[:match_id].to_i )
      if match.nil?
        return { :success? => false, :error => :no_match }
      else
        # binding.pry
        current_match = RPS::Match.new(match['p1_id'], match['p2_id'], match['id'])

        # if current_match.p2_id.nil?

        #     current_match.p2_id = params[:user_id].to_i
        #     current_match.update!
        # end

      end

      player = RPS.orm.find_user_by_id( params[:user_id] )
      if player.nil?
        return { :success? => false, :error => :no_user }
      end

      find_game = RPS.orm.find_current_game( params[:match_id].to_i)
      if find_game == false
        # binding.pry
        current_game = RPS::Game.new(match['id'], match['p1_id'], match['p2_id'])
        current_game.create!
        # binding.pry
        current_game.make_move!(current_game.id, params[:user_id], params[:move])
      else
        # something
        # binding.pry
        current_game = RPS::Game.new(find_game['match_id'], find_game['p1_id'],
          find_game['p2_id'], find_game['p1_move'], find_game['p2_move'], find_game['id'])
        current_game.make_move!(current_game.id, params[:user_id], params[:move])
      end

      # binding.pry
      if current_game.p1_move != nil && current_game.p2_move != nil

        @player1_wins = 0
        @player2_wins = 0
        @ties = 0

        all_games = RPS.orm.get_games_by_match_id( params[:match_id].to_i )

        all_games.each do |game|
          if game['p1_move'] == game['p2_move']
            @ties += 1
          elsif game['p1_move'] == 'rock'
            if game['p2_move'] == 'paper'
              @player2_wins += 1
            else
              @player1_wins += 1
            end
          elsif game['p1_move'] == 'paper'
            if game['p2_move'] == 'scissors'
              @player2_wins += 1
            else
              @player1_wins += 1
            end
          elsif game['p1_move'] == 'scissors'
            if game['p2_move'] == 'rock'
              @player2_wins += 1
            else
              @player1_wins += 1
            end
          else
            'error'
          end

          if @player1_wins == 3
            current_match.winner = current_match.p1_id
            current_match.save_winner!
            return current_match.p1_id
          elsif @player2_wins == 3
            current_match.winner = current_match.p2_id
            current_match.save_winner!
            return current_match.p2_id
          end
        end
      end

      # return hash to post results

    end


  end
end