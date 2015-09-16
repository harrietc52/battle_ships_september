class Printer
  def print_board(board)
    # printer.show_board
    results = "<div style='width:440px; float: left;'>"
    [*"A".."J"].each do |l|
      [*1..10].each do |n|
          if board.grid["#{l}#{n}".to_sym].content.is_a?(Water)
            if board.grid["#{l}#{n}".to_sym].hit == true
              results += "<div style='background-color:#666666; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
            else
              results += "<div style='background-color:#0000FF; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
            end
          else
            if board.grid["#{l}#{n}".to_sym].hit == true
              results += "<div style='background-color:#FF0000; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
            else
              results += "<div style='background-color:#009933; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"
            end
          end
      end
    end
    results += "</div>"
    results
  end

end
