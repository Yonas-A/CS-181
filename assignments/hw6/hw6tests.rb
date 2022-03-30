require_relative './hw6assignment'


def test_next_piece
  puts "next_piece #{MyPiece.next_piece(MyBoard)}"
  # mainLoop
end

def test_my_cheat_piece
  puts "my_cheat_piece: #{MyPiece.my_cheat_piece(MyBoard)}"
  # mainLoop
end

def test_my_cheat_move
  # puts "my_cheat_move #{MyBoard.my_cheat_move(MyBoard)}"
  # mainLoop
end

def test_rotate_180
  puts "rotate_180: #{MyTetris.rotate_180(MyBoard)}" 
  # mainLoop
end

test_next_piece
test_my_cheat_piece
# test_my_cheat_move
# test_rotate_180

# if ARGV.count == 0
#   test_next_piece
# elsif ARGV[0] == "next_piece"
#   test_next_piece
# elsif ARGV[0] == "my_cheat_piece"
#   test_my_cheat_piece
# else
#   puts "test output"
# end
