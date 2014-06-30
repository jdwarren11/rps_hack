module RPS
  class SignIn

    def self.run(params)
      user = RPS.orm.get_user_by_name( params[:name] )

      if user.nil?
        return { :success? => false, :error => :invalid_user }
      end

      password = params[:password]
      if !user.has_password?(password)
        return { :success? => false, :error => :invalid_password }
      end

      # user = RPS::User.new(user_data['name'],user_data['password'],user_data['id'].to_i)
      # session = RPS.orm.create_session( :user_id => user.id )
      return { :success? => true, :user_id => user.id }

    end
    
  end
end