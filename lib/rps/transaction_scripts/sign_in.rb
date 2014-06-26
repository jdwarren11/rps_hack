module RPS
  class SignIn

    def self.run(params)
      user = RPS.orm.get_user_by_username( params[:username] )

      if user.nil?
        return { :success? => false, :error => :invalid_user }
      end

      password = params[:password]
      if !user.has_password?(password)
        return { :success? => false, :error => :invalid_password }
      end

      session = RPS.orm.create_session( :user_id = user.id )
      return { :success? => true, :session_id => session }

    end
    
  end
end