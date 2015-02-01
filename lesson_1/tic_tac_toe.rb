require 'pry'

def draw_board(b)
 system 'clear'
  b.each do |pos, piece|
    if pos % 3 != 0
      print " #{piece} |"
    elsif pos % 3 == 0 && pos != 9
      print " #{piece}"
      puts " "
      puts " --+---+-- "
    else
      print " #{piece}"
      puts "\n"
    end
  end
end

def check_winner(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],
                   [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if b[line[0]] == 'X' and b[line[1]] == 'X' and b[line[2]] == 'X'
      return 'Player'
    elsif b[line[0]] == 'O' and b[line[1]] == 'O' and b[line[2]] == 'O'
      return 'Computer'
    end
  end
  nil
end

def board_fill_check(b)
  b.each do |k, v|
    if v == 'X' or v == 'O'
      next
    else
      return false
    end
  end
  return true
end

board = {1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ',
         5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}

loop do
  draw_board(board)
  puts "Choose a position (from 1 to 9) to place a piece:"
  pos = gets.chomp.to_i
  if board[pos] == ' '
    board[pos] = "X"
  else
    next
  end

  winner = check_winner(board)

  break if winner or board_fill_check(board)
  
  empty_places = board.select { |k, v| v == ' '}.keys
  c_pos = empty_places.sample
  board[c_pos] = "O"

  winner = check_winner(board)

  break if winner or board_fill_check(board)
end

draw_board(board)
if check_winner(board)
  puts "#{check_winner(board)} won!"
else
  puts "It's a tie!"
end