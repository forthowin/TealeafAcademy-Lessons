class Player
  attr_accessor :choice, :name

  def initialize(name)
    @name = name
  end

  def pick_choice
    begin
      puts "Choose one: (P/R/S)"
      c = gets.chomp.downcase
    end until PaperRockScissors::CHOICES.keys.include?(c)
    self.choice = c
  end

end

class Computer
  attr_accessor :choice
  attr_reader :name

  def initialize
    @name = 'computer'
  end

  def pick_choice
    self.choice = PaperRockScissors::CHOICES.keys.sample
  end
end

class PaperRockScissors
  attr_reader :player, :computer
  CHOICES = {"p" => "Paper", "r" => "Rock", "s" => "Scissors"}

  def initialize
    @player = Player.new('Bob')
    @computer = Computer.new
  end

  def print_choices
    puts "You picked #{CHOICES[player.choice]} and #{computer.name} picked #{CHOICES[computer.choice]}."
  end

  def winner
    if player.choice == computer.choice
      puts "It's a tie."
    elsif player.choice == "p" && computer.choice == "r"
      puts "Paper wraps Rock!"
      puts "You won!"
    elsif player.choice == "p" && computer.choice == "s"
      puts "Scissors cuts Paper!"
      puts "Computer won!"
    elsif player.choice == "r" && computer.choice == "p"
      puts "Paper wraps Rock!"
      puts "Computer won!"
    elsif player.choice == "r" && computer.choice == "s"
      puts "Rock smashes Scissor!"
      puts "You won!"
    elsif player.choice == "s" && computer.choice == "p"
      puts "Scissors cuts Paper!"
      puts "You won!"
    elsif player.choice == "s" && computer.choice == "r"
      puts "Rock smashes Scissor!"
      puts "Computer won!"
    end
  end

  def play_again?
    puts "Play again? (Y/N)"
    return true if gets.chomp.downcase == 'y'
    false
  end

  def play
    begin
      player.pick_choice
      computer.pick_choice
      print_choices
      winner
    end while play_again?
  end

end

PaperRockScissors.new.play
