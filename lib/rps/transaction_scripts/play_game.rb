module RPS
  class PlayGame

    # params => {:user_id, :match_id, :move, }

    def self.run(params)

      match = RPS.orm.find_match_by_id( params[:match_id] )
      if match.nil?
        return { :success? => false, :error => :no_match }
      end

      player = RPS.orm.get_player( params[:user_id] )
      if player.nil?
        return { :success? => false, :error => :no_user }
      end

      find_game = RPS.orm.find_current_game( params[:match_id])
      if find_game.nil?
        current_game = RPS::Game.new(match['m_id'], match['p1_id'], match['p2_id'])
        current_game.create!
        current_game.make_move!(current_game.id, params[:user_id], params[:move])
      else
        # something
        current_game = RPS::Game.new(find_game['m_id'], find_game['p1_id'],
          find_game['p2_id'], find_game['p1_move'], find_game['p2_move'], find_game['id'])
        current_game.make_move!(current_game.id, params[:user_id], params[:move])
      end


      if current_game.p1_move != nil && current_game.p2_move != nil

        @player1_wins = 0
        @player2_wins = 0
        @ties = 0

        all_games = RPS.orm.get_games_by_match_id( params[:match_id] )
        list.each do |game|
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
            'something went wrong'
          end

          if @player1_wins == 3
            match.winner = match.p1_id
            return match.p1_id
          elsif @player2_wins == 3
            match.winner = match.p2_id
            return match.p2_id
          end
        end
      end

    end


  end
end