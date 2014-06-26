require 'rubygems'
require 'sinatra'
require 'pry-byebug'

set :bind, '0.0.0.0'

get '/sign-in' do 

end

get '/' do
RPS.PlayGame.run(params)
end

post '/' do 

end