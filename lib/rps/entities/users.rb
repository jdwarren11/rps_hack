# using sha1 is bad, but Nick told us we could be bad this one time
require 'digest/sha1' 

class RPS::User
  attr_reader :id, :username, :password_digest
  
  def initialize(name, password_digest, id=nil)
    @name = name
    @password_digest = password_digest
    @id = id
  end

  def update_password(password)
    digest = Digest::SHA1.hexdigest(password)
    @password_digest = digest
  end

  def has_password?(password)
    incoming = Digest::SHA1.hexdigest(password)
    return true if incoming == @password_digest
  end

end