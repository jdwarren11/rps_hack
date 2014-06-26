module RPS
  class SignUp

    def self.run(params)
      # check to see if username already exists
      user = RPS.orm.get_user_by_username(params[:username])
      if user.num_tuples.zero?
        RPS.orm.create_user(params[:username], params[:password])
        RPS::SignIn.run(params)
      else
        false
        # return message username already exists
      end
    end

  




  end
end