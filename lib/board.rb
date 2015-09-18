class Board
	attr_reader :grid

	def initialize(content)
		@grid = {}
		[*"A".."J"].each do |l|
			[*1..10].each do |n|
				@grid["#{l}#{n}".to_sym] = content.new
					@grid["#{l}#{n}".to_sym].content = Water.new
			end
		end
	end

	def place(ship, coord, orientation = :horizontally)
		coords = [coord]
		(ship.size - 1).times{coords << next_coord(coords.last, orientation)}
		put_on_grid_if_possible(coords, ship)
	end

	def comp_place(ship)
		rand_l = [*"A".."J"].sample
		rand_n = [*1..10].sample
		rand_coor = rand_l + rand_n.to_s
		final_rand_coord = rand_coor.to_sym

		begin
			place(ship, final_rand_coord, [:horizontally, :vertically].sample)
		rescue
			comp_place(ship)
		end
	end

	def show_board(printer_class)
		printer = printer_class.new
		printer.print_board(self)
	end


	# def show_opponent_board
	# 	results = "<div style='width:440px; float: left;'>"
	# 	[*"A".."J"].each do |l|
	# 		[*1..10].each do |n|
	# 				if @grid["#{l}#{n}".to_sym].content.is_a?(Water)
	# 					if @grid["#{l}#{n}".to_sym].hit == true
	# 						results += "<div style='background-color:#666666; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
	# 					else
	# 						results += "<div style='background-color:#0000FF; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
	# 					end
	# 				else
	# 					if @grid["#{l}#{n}".to_sym].hit == true
	# 						results += "<div style='background-color:#FF0000; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
	# 					else
	# 						results += "<div style='background-color:#0000FF; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
	# 					end
	# 				end
	# 		end
	# 	end
	# 	results += "</div>"
	# 	results
	# end

	def floating_ships?
		ships.any?(&:floating?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content).uniq
	end

	def ships_count
		ships.count
	end

	def loss?

      self.ships.each do |ship|
          return false if ship.sunk? == false
      end
      return true
  end


private

 	def next_coord(coord, orientation)
		orientation == :vertically ? next_vertical(coord) : (coord.to_s[0] + (coord.to_s[-1].to_i + 1).to_s).to_sym
	end

	def next_vertical(coord)
		coord.to_s.reverse.next.reverse.to_sym
	end

	def is_a_ship?(cell)
		cell.content.respond_to?(:sunk?)
	end

	def any_coord_not_on_grid?(coords)
		(grid.keys & coords) != coords
	end

	def any_coord_is_already_a_ship?(coords)
		coords.any?{|coord| is_a_ship?(grid[coord])}
	end

	def raise_errors_if_cant_place_ship(coords)
		raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(coords)
		raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(coords)
	end

	def put_on_grid_if_possible(coords, ship)
		raise_errors_if_cant_place_ship(coords)
		coords.each{|coord|grid[coord].content = ship}
	end

end
