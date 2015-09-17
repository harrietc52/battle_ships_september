class Printer
  def print_board(board)
    # printer.show_board
    results = "<div style='; width: 440px; float: left;'>"
    # results += "<div style='background-color:#DCDCDC; height: 40px; width:40px; display:inline-block; border: 1px solid white;'> </div>"

    [*1..10].each do |x|
      results += "<div style='background-color:#DCDCDC; height: 40px; width:40px; display:inline-block; border: 1px solid white; text-align: center; font: 20px sans-serif;'>#{x}</div>"
    end

    [*"A".."J"].each do |l|
      [*1..10].each do |n|
          if board.grid["#{l}#{n}".to_sym].content.is_a?(Water)
            if board.grid["#{l}#{n}".to_sym].hit == true
              results += "<div style='background-color:#666666; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>" #grey
            else
              results += "<div style='background-color:#0000FF; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>" #blue
            end
          else
            if board.grid["#{l}#{n}".to_sym].hit == true
              results += "<div style='background-color:#FF0000; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>" #red
            else
              results += "<div style='background-color:#009933; height:40px; width:40px; display:inline-block; border: 1px solid white;'> </div>" #green
            end
          end
      end
    end
    results += "</div>"
    results
  end

end
