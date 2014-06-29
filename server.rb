require 'rubygems'
require 'sinatra'
require 'pry-byebug'
require './lib/rps.rb'

set :bind, '0.0.0.0'

post '/sign_up' do
  RPS::SignUp.run(params)
end

get '/' do
# RPS.PlayGame.run(params)
 erb :sign_in_page
end

# post '/' do 

# end