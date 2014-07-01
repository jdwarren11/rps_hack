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

get '/start-match/user_id/:user_id' do
  @start_match = RPS::AssignMatch.run(session[:user_id])
  if @start_match
    redirect to '/'
  end
end

get '/gameplay/:match_id' do
  @bodyclass = "gameplay"
  params[:match_id]
  session[:user_id]
  match = RPS.orm.find_match_by_id(params[:match_id])
  @current_match = RPS::Match.new(match['p1_id'], match['p2_id'], match['id'], match['winner'])
  @games = RPS.orm.get_games_by_match_id(params[:match_id])
    erb :game_play, layout: :layout_user_home
end

get '/gameplay/move/:move/user_id/:user_id/match_id/:match_id' do
  @something = RPS::PlayGame.run(params)
  redirect to '/gameplay/' + params[:match_id]
end

# post '/gameplay/:match_id' do
#   params[:match_id]
#   session[:user_id]
#   erb :game_play
# end

post '/sign_up' do
  @bodyclass = "signin"
  result = RPS::SignUp.run(params)
  if result[:success?]
    session[:user_id] = result[:user_id]
    redirect to '/'
  else
    "user does not exist"
  end
end


post '/sign_in' do
  @bodyclass = "signin"
  result = RPS::SignIn.run(params)
  if result[:success?]
    session[:user_id] = result[:user_id]
    redirect to '/'
  else
    "user does not exist"
    redirect to '/'
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