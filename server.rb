require 'rubygems'
require 'sinatra'
require 'pry-byebug'
require './lib/rps.rb'

enable :sessions

set :bind, '0.0.0.0'


get '/' do 
  # puts 'this is params' + params.to_s
  # puts 'this is session' + session.to_s
  # session.each {|k,e|  puts k.to_s + e.to_s}
  if session[:user_id]
    user = RPS.orm.find_user_by_id(session[:user_id])
    @name = user.name
    @user_stats = user.get_record

    erb :user_home, layout: :layout_user_home
  else
    erb :sign_in_page
  end
end

get '/gameplay/:match_id' do
  params[:match_id]
  session[:user_id]
  @games = RPS.orm.get_games_by_match_id(params[:match_id])
  erb :game_play
end

get '/gameplay/move/:move' do
  # procces the move
  puts params[:move]
  redirect to '/gameplay/8'
end

# post '/gameplay/:match_id' do
#   params[:match_id]
#   session[:user_id]
#   erb :game_play
# end

post '/sign_up' do
  result = RPS::SignUp.run(params)
  if result[:success?]
    session[:user_id] = result[:user_id]
    redirect to '/'
  else
    "user does not exist"
  end
end


post '/sign_in' do
  result = RPS::SignIn.run(params)
  if result[:success?]
    session[:user_id] = result[:user_id]
    redirect to '/'
  else
    "user does not exist"
  end
end

# get '/signout' do
#   "<form method='post' action='/signout'>
#     <input type='submit' value='Logout'>
#     </form>"
# end

post '/signout' do
  session.clear
  redirect to '/'
end