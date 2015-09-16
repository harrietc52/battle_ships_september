require 'sinatra/base'
require_relative 'board'
require_relative 'ship'
require_relative 'cell'
require_relative 'water'

class BattleshipWeb < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views')}

  get '/' do
    erb :index
  end

  get '/name' do
  	@name = params[:name]
    erb :new_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
