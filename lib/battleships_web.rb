require 'sinatra/base'
require_relative 'board'
require_relative 'ship'
require_relative 'cell'
require_relative 'water'
require_relative 'htmlprinter'

class BattleshipWeb < Sinatra::Base

  enable :sessions

  $board = Board.new(Cell)
  $board_comp = Board.new(Cell)

  set :views, proc { File.join(root, '..', 'views')}

  get '/' do
    erb :index
  end

  get '/name' do
  	@name = params[:name]
    session[:name] = params[:name]
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

    @name = session[:name]
    @error = session[:error_message]

    if params[:position] == nil then
      #initialise ships
      session[:fleet] = [[:aircraft_carrier, 'Aircraft Carrier (5)'],
                         [:battleship, 'Battleship (4)'],
                         [:destroyer, 'Destroyer (3)'],
                         [:submarine, 'Submarine (3)'],
                         [:patrol_boat, 'Patrol Boat (2)']]
    @fleet = session[:fleet]

    else
      @fleet = session[:fleet]
      ship = Ship.send(params[:type].to_sym)
      begin
        $board.place(ship, params[:position].to_sym, params[:orientation].to_sym)
        session[:fleet].delete_if{ |item| item[0] == params[:type].to_sym}
      rescue
        session[:error_message] = "There is an error"
      end
    end

    @show_board = $board.show_board(Printer)

    erb :ship_placement

  end

    get '/game' do

      @fire_coor = params[:fire_coor]

      unless $board_comp.ships_count == 5
        comp_fleet = [Ship.aircraft_carrier, Ship.battleship, Ship.destroyer, Ship.submarine, Ship.patrol_boat]
        comp_fleet.each do |comp_ship|
          $board_comp.comp_place(comp_ship)
        end
      end


      if @fire_coor
        $board_comp.shoot_at(@fire_coor.to_sym)
      end

      @show_my_board = $board.show_board(Printer)
      @show_comp_board = $board_comp.show_board(Printer)
      
      erb :game
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
