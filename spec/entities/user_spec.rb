require 'spec_helper.rb'

describe RPS::User do

  describe "initialize" do
    it "initializes a username and password_digest" do
      # pending "You need to implement password hashing first"
      user = RPS::User.new("joe")
      user.update_password("joe's password")
      user.create!

      expect(user.id).to eq('4')
      expect(user.name).to eq("joe")

      expect(user.has_password? "joe's password").to eq true
    end
  end
end