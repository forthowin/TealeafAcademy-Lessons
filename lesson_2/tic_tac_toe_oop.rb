class Player
  attr_reader :name

  def initialize(n)
    @name = n
  end
end

class Human < Player
  attr_accessor :choice

  def pick_pos(b)
    loop do
      @choice = gets.chomp.to_i
      break if b.data.keys.include?(choice) && b.data[choice] == ' '
      puts "Invalid input"
    end
    b.data[choice] = 'X'
  end

end

class Computer < Player
  attr_accessor :choice
  
  def pick_pos(b)
    remaining_board_pos = b.get_remaining_board_pos
    @choice = remaining_board_pos.keys.sample
    b.data[choice] = 'O'
  end
end

class Board
  attr_accessor :data

  def initialize
    @data = {1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ',
              6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
  end

  def draw
    system 'clear'
    data.each do |pos, piece|
      if pos % 3 != 0
        print " #{piece} |"
      elsif pos % 3 == 0 && pos != 9
        print " #{piece}"
        puts " "
        puts " --+---+-- "
      else
        print " #{piece}"
        puts "\n\n"
      end
    end
    puts "Choose a position (from 1 to 9) to place a piece:"
  end

  def get_remaining_board_pos
    data.select {|p, c| c == ' ' }
  end

end

class Game
  attr_reader :player1, :player2, :board

  def initialize(n, m)
    @board = Board.new
    @player1 = Human.new(n)
    @player2 = Computer.new(m)
  end

  def check_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],
                     [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      if board.data[line[0]] == 'X' and board.data[line[1]] == 'X' and board.data[line[2]] == 'X'
        return player1.name
      elsif board.data[line[0]] == 'O' and board.data[line[1]] == 'O' and board.data[line[2]] == 'O'
        return player2.name
      end
    end
    nil
  end

  def play
    board.draw
    loop do
      player1.pick_pos(board)
      board.draw
      winner = check_winner
      if winner 
        puts "#{winner} wins!"
        break
      elsif board.get_remaining_board_pos.empty?
        puts "It's a tie."
        break
      end
      player2.pick_pos(board)
      board.draw
      winner = check_winner
      if winner 
        puts "#{winner} wins!"
        break
      elsif board.get_remaining_board_pos.empty?
        puts "It's a tie."
        break
      end
    end
  end
end

Game.new('Bob', 'XG12').play