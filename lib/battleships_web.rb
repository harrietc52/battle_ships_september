require 'sinatra/base'
require_relative 'board'
require_relative 'ship'
require_relative 'cell'
require_relative 'water'
require_relative 'htmlprinter'

class BattleshipWeb < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views')}

  get '/' do
    erb :index
  end

  get '/name' do
  	@name = params[:name]
    erb :new_game
  end

  get '/board_example' do
    board = Board.new(Cell)
    ship1 = Ship.new(5)
    ship2 = Ship.new(4)
    ship3 = Ship.new(3)
    board.place(ship1, :D5)
    board.place(ship2, :B2)
    board.place(ship3, :J2)
    board.shoot_at(:D5)
    board.shoot_at(:C3)
    board.shoot_at(:B9)
    board.shoot_at(:E7)
    board.shoot_at(:G3)
    board.shoot_at(:H7)
    board.shoot_at(:F8)
    board.shoot_at(:A4)
    board.shoot_at(:J2)

    @results = board.show_board(Printer)
    # @results += "<div style='width:10px; float: left'></div>"
    # @results += board.show_opponent_board

    erb :board_example
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
