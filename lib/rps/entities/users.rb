class TM::Users
  
  def initialize(name, password, id=nil)
    @name = name
    @id = id
  end

  def create!
    id_from_db = RPS.orm_create_user
    @id = id_from_db
    self
  end

end