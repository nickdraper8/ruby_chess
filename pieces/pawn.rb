# should also have a moves method
require_relative "piece"

class Pawn < Piece

    def symbol
        ' ♟ '.colorize(color)
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        # debugger
        (self.to_s == :red && self.pos[0] == 1) || (self.to_s == :white && self.pos[0] == 6)
    end

    def forward_dir
        self.to_s == :red ? 1 : -1
    end

    def forward_steps
        # debugger
        return [] unless @board[[(self.pos[0] + forward_dir), self.pos[1]]].empty?
        forward_moves = []
        if at_start_row?
            forward_moves += [[self.pos[0] + forward_dir, self.pos[1]],[self.pos[0] + (forward_dir * 2), self.pos[1]]]
        else
            forward_moves += [[self.pos[0] + forward_dir, self.pos[1]]]
        end
        forward_moves.select { |move| @board[move].empty? }
    end

    def side_attacks
        # debugger
        attacks = []

        att_1 = [(self.pos[0] + forward_dir), (self.pos[1] + 1)]
        att_2 = [(self.pos[0] + forward_dir), (self.pos[1] - 1)]

        attacks << att_1 if @board.valid_pos?(att_1) && @board[att_1].to_s != self.to_s && !@board[att_1].empty?
        attacks << att_2 if @board.valid_pos?(att_2) && @board[att_2].to_s != self.to_s && !@board[att_2].empty?
        attacks
    end
end
