require_relative "piece"
require_relative "stepable"

class King < Piece
   include Stepable 
    
    def symbol
        ' ♛ '.colorize(@color)
    end

    protected

    def move_diffs
        moves = [] 
        # all possible moves of the knight
        x_moves = [0, 0, 1,-1, -1, -1, 1, 1]
        y_moves = [1,-1, 0, 0, -1, 1, 1, -1]
        i = 0 
        while i < 8 
            moves << [y_moves[i], x_moves[i]]
            i += 1
        end
        return moves 
    end 

end 