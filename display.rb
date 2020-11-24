require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display

    attr_reader :cursor

    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
        @message = ''
        @turn = "Player1"
    end

    def render(cursor_pos, selected_pos, *possible_move_pos)
        print "    "
        (["a","b","c","d","e","f","g","h"]).each {|x| print "#{x}   "}
        puts
        puts
        @board.grid.each_with_index do |row, y|
            print "#{y+1}  "
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
        puts @turn + "'s turn"
        # debugger
        puts @message
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
            # debugger
            if @cursor.selected && selected_pos == @cursor.cursor_pos
                selected_pos = [-1,-1]
                @cursor.toggle_selected
                possible_moves = []
                @message = ''
            elsif @cursor.selected
                selected_pos = @cursor.cursor_pos
                if @cursor.selected && possible_moves.include?(selected_pos)
                    debugger
                    @board.move_piece(@cursor.cursor_pos, selected_pos)
                end 
                possible_moves = @board[selected_pos].moves
                self.piece_selected_message(selected_pos);
            end
            system('clear')
            self.render(@cursor.cursor_pos, selected_pos, *possible_moves)
            @cursor.get_input
        end
    end

    def piece_selected_message(selected_pos)
        letters = ["a","b","c","d","e","f","g","h"]
        letter = letters[selected_pos[1]]
        @message = "#{@turn} has selected their #{@board[selected_pos].class.name} at #{letter}#{selected_pos[0]+1}"
    end

    def piece_moved_message(start_pos, end_pos)
        letters = ["a","b","c","d","e","f","g","h"]
        letter = letters[selected_pos[1]]
        @message = "#{@turn} has selected their #{@board[selected_pos].class.name} at #{letter}#{selected_pos[0]+1}"
    end
end

b = Board.new
d = Display.new(b)
# d.render([0,0])
d.play