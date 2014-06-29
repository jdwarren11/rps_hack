module RPS
  class SignUp

    def self.run(params)
      # check to see if username already exists
      user_data = RPS.orm.get_user_by_username(params[:username])
      if user_data.num_tuples.zero?
        new_user = RPS::User.new(params[:username])
        new_user.update_password(params[:password])
        new_user.create!
        RPS::SignIn.run(params)
      else
        false
        # return message username already exists
      end
    end

  




  end
end