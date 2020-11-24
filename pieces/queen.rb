require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable

  def symbol
    ' ♚ '.colorize(@color)
  end

  protected

  def move_dirs
    self.diagonal_dirs + self.orthagonal_dirs
  end
end