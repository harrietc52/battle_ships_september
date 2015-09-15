require 'sinatra/base'

class BattleshipWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/name' do
  	@name = params[:name]
    erb :name_form
  end

  get '/board' do
  	erb :board
  end

  set :views, proc { File.join(root, '..', 'views')}
  # start the server if ruby file executed directly
  run! if app_file == $0

end
