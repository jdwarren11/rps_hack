require 'spec_helper.rb'
require 'rspec'
require 'pry-byebug'



describe 'RPS::Match' do 

  before(:all) do
    user =  RPS::User.new('Nando', 'Password123')
    user.create!
    match = RPS::Match.new(1)
    match.create!
  end

  describe 'initialize' do 
    it 'should initialize and create a new match' do 
      expect(match.id).to eq(1)
      expect(match.p1_id).to eq(1)
    end
  end

end