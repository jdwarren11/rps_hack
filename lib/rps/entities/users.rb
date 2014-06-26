# this is bad
require 'digest/sha1' 

class RPS::Users
  
  def initialize(name, password_digest, id=nil)
    @name = name
    @id = id
    @password_digest = password_digest
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