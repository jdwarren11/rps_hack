module RPS
  class AssignMatch
    
    def self.run(player_id)
      open_match = RPS.orm.find_open_match
      if open_match && (open_match['p1_id'] != player_id)
        RPS.orm.assign_new_player(open_match['id'], player_id)
      else
        new_match = RPS::Match.new(player_id)
        new_match.create!
      end
    end
  end
end