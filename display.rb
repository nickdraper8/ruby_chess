require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display

    attr_reader :cursor

    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    def render(cursor_pos, selected_pos, *possible_move_pos)
        print "    "
        (0...8).each {|x| print "#{x}   "}
        puts
        puts
        @board.grid.each_with_index do |row, y|
            print "#{y}  "
            row.each_with_index do |space, x| 
                # if space.symbol.nil?
                #     print "___ "
                # else
                #     print "#{space.symbol} "
                # end
                if [y,x] == cursor_pos
                    print "#{space.symbol.colorize(:yellow)} " 
                elsif [y,x] == selected_pos
                    print "#{space.symbol.colorize(:green)} "
                elsif possible_move_pos.include?([y,x])
                    print "#{space.symbol.colorize(:blue)} "
                else
                    print "#{space.symbol.colorize(space.color)} "
                end
            end
            puts
            puts
        end
    end

    def play
        # debugger
        go = true
        selected_pos = [-1,-1]
        possible_moves = []
        while go
            # debugger
            # need to put in logic to see if there is already a piece that is 
            # selected, and not just the same as the cursor_pos
            if @cursor.selected && selected_pos == @cursor.cursor_pos
                selected_pos = [-1,-1]
                @cursor.toggle_selected
                possible_moves = []
            elsif @cursor.selected
                selected_pos = @cursor.cursor_pos 
                @cursor.toggle_selected
                possible_moves = @board[selected_pos].moves
            end
            system('clear')
            self.render(@cursor.cursor_pos, selected_pos, *possible_moves)
            @cursor.get_input
        end
    end
end

b = Board.new
d = Display.new(b)
# d.render([0,0])
d.play