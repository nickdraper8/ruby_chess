module Slideable

  # ORTHAGONALL_DIRS stores an array of horizontal directions
  ORTHAGONAL_DIRS = [
    [0, -1], # left
    [0, 1], # right
    [1, 0], # up (vertical)
    [-1, 0]  # down (vertical)
  ].freeze

  # DIAGONAL_DIRS stores an array of diagonal directions
  DIAGONAL_DIRS = [
    [1,-1], # up + left
    [1,1], # up + right
    [-1,-1], # down + left
    [-1,1]  # down + right
  ].freeze


  def orthagonal_dirs
    ORTHAGONAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  # should return an array of places a Piece can move to
  def moves
    # debugger
    # create array to collect moves
    valid_moves = []

    # iterate over each of the directions in which a slideable piece can move
      # use the Piece subclass' `#move_dirs` method to get this info
      # for each direction, collect all possible moves in that direction
        # and add them to your moves array 
        # (use the `grow_unblocked_moves_in_dir` helper method)
        # helper method produces the possible moves in that given direction
    self.move_dirs.each do |dir|
        valid_moves += grow_unblocked_moves_in_dir(*dir)
    end
    valid_moves
    # return the final array of moves (containing all possible moves in all directions)
  end


  private

  def move_dirs
    # subclass implements this
    # good programming practice, where module's `moves` method needs a `move_dirs` method to exist.
    # this module method `move_dirs` simply raises a custom error to tell that it needs whatever class that includes this module to implement a `move_dirs` method on its class
    raise NotImplementedError # this only executes if the class including this module doesn't have `move_dirs` defined on it
  end


  # this helper method is only responsible for collecting all moves in a given direction
  # the given direction is represented by two args, the combination of a dx and dy
  def grow_unblocked_moves_in_dir(dy, dx)
    # debugger
    # create an array to collect moves
    valid_moves = []
    # get the piece's current row and current column
    current_row = self.pos[0] + dy
    current_col = self.pos[1] + dx
    # in a loop:
      # continually increment the piece's current row and current column to generate a new position
      # stop looping if the new position is invalid (not on the board); the piece can't move in this direction
      # if the new position is empty, the piece can move here, so add the new position to the moves array
      # if the new position is occupied with a piece of the opposite color, the piece can move here (to capture the opposing piece), so add the new position to the moves array
        # but, the piece cannot continue to move past this piece, so stop looping
      # if the new position is occupied with a piece of the same color, stop looping
    while current_row.between?(0,7) && current_col.between?(0,7)
        new_pos = [current_row, current_col]
        if @board[new_pos].empty?
            valid_moves << new_pos
        elsif @board[new_pos].to_s != self.to_s
            valid_moves << new_pos
            break
        else
            break
        end
        current_row += dy
        current_col += dx
    end
    valid_moves
            

    # return the final moves array
  end
end




# Note: you can invoke methods from the piece from within the module methods, and vice versa. It is a two way street!
