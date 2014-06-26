module RPS
  class PlayGame

    def self.run(params)
      # params => {:user_id => 23, :match_id => 1}
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




    end