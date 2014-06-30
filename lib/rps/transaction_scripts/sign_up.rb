module RPS
  class SignUp

    def self.run(params)
      # check to see if username already exists
      user = RPS.orm.get_user_by_name(params[:name])
      if user.nil?
        new_user = RPS::User.new(params[:name])
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