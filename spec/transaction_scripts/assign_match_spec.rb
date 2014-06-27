require 'spec_helper.rb'
require 'rspec'
require 'pry-byebug'

describe 'RPS::AssignMatch' do 

  it 'check is a opne game is aviable and assign a user' do

    new_player = RPS::User.new('Andy2','123abc')
    new_player.create!
    new_game_id = RPS::AssignMatch.run(new_player.id)

    expect(new_game_id).to eq('3')


  end
  
end