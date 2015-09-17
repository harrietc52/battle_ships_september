require 'sinatra/base'
require_relative 'board'
require_relative 'ship'
require_relative 'cell'
require_relative 'water'
require_relative 'htmlprinter'

class BattleshipWeb < Sinatra::Base

  enable :sessions

  $board = Board.new(Cell)

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

  get '/ship_placement' do

    if params[:position] == nil
    else
      ship = Ship.send(params[:type].to_sym)
      $board.place(ship, params[:position].to_sym, params[:orientation].to_sym)
    end

    @show_board = $board.show_board(Printer)
    erb :ship_placement

  end

    # if session[:board] != nil
    #   puts "IT IS NOT SAVED!!!!"
    # end
    # session[:board] = Board.new(Cell) if session[:board] == nil
    # # ship = Ship.new(4)
    # # session[:board].place(ship,:A2) if session[:board].ships_count == 0
    # @board = 'SHIP PLACEMENT'
    # erb :ship_placement

  # get '/test' do
  #
  # end

  # get '/show_board' do
  #   puts ''
  #   puts ''
  #   puts ''
  #   p session[:board]
  #   ship = Ship.new(4)
  #   # session[:board].place(ship, params[:position].to_sym)
  #   # @show_board = session[:board].show_board(Printer)
  #   erb :show_board
  # end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
