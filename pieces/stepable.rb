module Stepable
    
    def moves
        # debugger 
        valid_positions = []
        
        self.move_diffs.each do |move|

            new_pos = [(self.pos[0] + move[0]), (self.pos[1] + move[1])]

            if (new_pos[0].between?(0,7) && new_pos[1].between?(0,7)) && (@board[new_pos].empty? || @board[new_pos].to_s != self.to_s)
                valid_positions << new_pos
            end
        end
        valid_positions
    end 
    
    private 
    
    def move_diffs
        # subclass implements this
        raise NotImplementedError
    end

    
end