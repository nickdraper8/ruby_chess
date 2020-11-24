require_relative "./pieces/piece.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/bishop.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/rook.rb"
require_relative "./pieces/pawn.rb"
require_relative "./pieces/null_piece.rb"
# require_relative "./pieces/null_piece.rb"
require 'byebug'

class Board 

    attr_accessor :grid
    def initialize 
       @grid = Array.new(8) {Array.new(8, " ")}  
       @grid = self.init_board 
    end 

        
    def init_board
        # debugger
        @grid.each_with_index do |row, y| 
            if y.between?(2,5)
                row.each_with_index do |ele, x|
                    row[x] = NullPiece.instance
                end 
            elsif y == 0 
                row.each_with_index do |ele, x|
                    if x == 0 || x == 7
                        row[x] = Rook.new(:red, self, [y, x])
                    elsif x == 1 || x == 6
                        row[x] = Knight.new(:red, self, [y, x])
                    elsif x == 2 || x == 5
                        row[x] = Bishop.new(:red, self, [y, x])
                    elsif x == 3
                        row[x] = King.new(:red, self, [y, x])
                    else
                        row[x] = Queen.new(:red, self, [y, x])
                    end 
                end
            elsif y == 1
                row.each_with_index {|ele, x| row[x] = Pawn.new(:red, self, [y, x])}
            elsif y == 6
                row.each_with_index {|ele, x| row[x] = Pawn.new(:white, self, [y, x])}
            else
                row.each_with_index do |ele, x|
                    if x == 0 || x == 7
                        row[x] = Rook.new(:white, self, [y, x])
                    elsif x == 1 || x == 6
                        row[x] = Knight.new(:white, self, [y, x])
                    elsif x == 2 || x == 5
                        row[x] = Bishop.new(:white, self, [y, x])
                    elsif x == 3
                        row[x] = King.new(:white, self, [y, x])
                    else
                        row[x] = Queen.new(:white, self, [y, x])
                    end 
                end
            end 
        end 
    end 

    def [](pos)
        # debugger
        @grid[pos[0]][pos[1]]
    end 

    def []=(pos, value)
        @grid[pos[0]][pos[1]] = value
    end 

    #  this now lives in display.rb

    # def print_grid(selected_pos) 
    #     # debugger
    #     print "    "
    #     (0...8).each {|x| print "#{x}   "}
    #     puts
    #     puts
    #     @grid.each_with_index do |row, y|
    #         print "#{y}  "
    #         row.each_with_index do |space, x| 
    #             # if space.symbol.nil?
    #             #     print "___ "
    #             # else
    #             #     print "#{space.symbol} "
    #             # end
    #             if [y,x] == selected_pos
    #                 if 
    #                 print "#{space.symbol.colorize(:yellow)} " 
    #             else
    #                 print "#{space.symbol.colorize(space.color)} "
    #             end
    #         end
    #         puts
    #         puts
    #     end
    # end 

    def move_piece(start_pos, end_pos)
        # debugger
        raise "invalid position given, off board" unless valid_pos?(start_pos) && valid_pos?(end_pos)
        raise "no piece at starting position" if self[start_pos].nil? 
        valid_moves = self[start_pos].moves
        raise "invalid move for #{self[start_pos].symbol}" unless valid_moves.include?(end_pos)

        # need to edit this code to account for taking an enemy piece
        # if start_pos is one color and moves into another colors space,
        # also raise error if start_pos tries to move to space of same color
        self[start_pos].pos = end_pos
        self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
        self[start_pos] = NullPiece.instance unless self[start_pos].empty?
    end 

    def valid_pos?(pos)
        pos[0].between?(0,7) && pos[1].between?(0,7) 
    end 

    def play
        while true
            system('clear')
            self.print_grid
            puts "enter a starting position using this format '1,2'"
            start_pos = gets.chomp
            start_pos = start_pos.split(',').map {|ele| Integer(ele)}
            puts "now enter an ending position"
            end_pos = gets.chomp
            end_pos = end_pos.split(',').map {|ele| Integer(ele)}
            # debugger
            self.move_piece(start_pos, end_pos)
        end
    end
end 



# b = Board.new

# b.print_grid([0,0])
