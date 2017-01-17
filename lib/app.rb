require 'sinatra/base'
require_relative 'player'

class Battle < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :index #, :locals => {:player_1_name => params[:player_1_name],:player_2_name => params[:player_2_name]}
  end

  post '/names' do
    $player_1 = Player.new params[:player_1_name]
    $player_2 = Player.new params[:player_2_name]
    redirect to('/play')
  end

  get '/play' do
    @player_1_name = $player_1.name
    @player_2_name = $player_2.name
    @player_1_health = $player_1.health
    @player_2_health = $player_2.health
    erb :play
  end

  get '/attack' do
    $player_1.attack $player_2
    @player_1_name = $player_1.name
    @player_2_name = $player_2.name
    erb :attack
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
