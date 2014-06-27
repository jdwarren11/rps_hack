# THIS GOES IN THE SIGN IN SCRIPT
# DELETE THIS ONCE TRANSFERRED TO CORRECT FILE

module RPS
  class Sesh

    def self.run
      r_string = (0..8).map {rand}.join
      {session_id: r_string}
    end


  end
end