module RPS
  class AssignMatch
    
    def self.run(player_id)
      open_match_id = RPS.orm.find_open_match
      puts 'id: ' + open_match_id.to_s
      if open_match_id

        RPS.orm.assign_new_player(open_match_id, player_id)
      
      else
        
        puts 'check??'
        
        RPS.orm.create_match(player_id)
        RPS::Match.new(player_id)
      
      end
    end


  end
end