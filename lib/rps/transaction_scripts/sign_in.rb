module RPS
  class SignIn

    def self.run(params)
      user_data = RPS.orm.get_user_by_username( params[:username] )

      if user.nil?
        return { :success? => false, :error => :invalid_user }
      end

      password = params[:password]
      if !user.has_password?(password)
        return { :success? => false, :error => :invalid_password }
      end

      user = RPS::User.new(user_data['name'],user_data['password'],user_data['id'].to_i)
      session = RPS.orm.create_session( :user_id => user.id )
      return { :success? => true, :session_id => session }

    end
    
  end
end