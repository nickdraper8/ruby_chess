require_relative 'piece'
require 'singleton'

class NullPiece < Piece

    include Singleton

    def initialize
        @color = nil
    end

    def symbol
        "___".colorize(:white)
    end

    def moves

    end

end