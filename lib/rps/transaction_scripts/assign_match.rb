module RPS
  class AssignMatch
    
    def self.run(player_id)
      check = RPS.orm.find_open_match
      if check?
        RPS.orm.assign_new_player(player_id)
      else
        RPS.orm.create_match(player_id)
        RPS::Match.new(player_id)
      end
    end


  end
end