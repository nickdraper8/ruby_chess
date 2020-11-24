# knowing if some move is valid?
# all logic for understanding if a certain move is 
# valid should be incldued in the moves function
require 'colorize'
require 'byebug'

class Piece 

    attr_reader :pos, :color

    def initialize(color, board, pos) 
        @color = color 
        @board = board
        @pos = pos 
    end
    
    # def inspect
    #     @color.inspect
    # end

    def empty? 
        @color.nil? 
    end 

    def pos=(new_pos)
        @pos = new_pos
    end 

    #this gets the symbol of the piece
    def symbol
        @color 
    end 

    #this gets the color of the piece
    def to_s
        @color
    end

    # def valid_moves
    #     moves.reject { |end_pos| move_into_check(end_pos) }
    # end

end 





