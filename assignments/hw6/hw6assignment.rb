# UC Riverside, Programming Languages, Homework 6, hw6runner.rb
# Based on code from University of Washington

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece

  All_My_Pieces = All_Pieces + 
                  [rotations([[0, 0], [1, 0], [0, 1], [1, 1],[0, 2]]), # WIDE L
                  [[[0, 0], [-1, 0], [1, 0], [2, 0],[-2,0]], # long 
                  [[0, 0], [0, -1], [0, 1], [0, 2],[0,-2]]],
                  rotations([[0, 0], [0, 1], [1, 1]])] # short L

  Cheat_Piece = [[[0,0]]] # doesn't rotate

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.my_cheat_piece (board)
    MyPiece.new(Cheat_Piece.sample, board)
  end

end

class MyBoard < Board

  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @cheat_move = false
    @score = 0
    @game = game
    @delay = 500
  end

  # gets the next piece
  def next_piece
    if @cheat_move
      @current_block = MyPiece.my_cheat_piece(self)
      @cheat_move = false
      @score -= 100
    else 
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # note: update current to iterate over each size instead of the 0-3
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..@current_block.current_rotation.size-1).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
      # puts "Length: #{@current_block.current_rotation}:  #{@current_block.current_rotation.size}:  #{@current_block.position}:   #{index}"
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def my_cheat_move
    if !game_over? and @score > 100 and !@cheat_move
      @cheat_move = true
    end
  end

  # rotates the current piece 180˚ if possible
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

end

class MyTetris < Tetris

  # creates a canvas and the board that interacts with it
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.my_cheat_move})
  end
  alias my_key_bindings :key_bindings

end
