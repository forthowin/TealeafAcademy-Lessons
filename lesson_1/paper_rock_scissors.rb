puts "Play Paper Rock Scissors!"
choice = {"p" => "Paper", "r" => "Rock", "s" => "Scissors"}

begin

  begin
    puts "Choose one: (P/R/S)"
    p_choice = gets.chomp.downcase
  end until choice.keys.include?(p_choice)

  c_choice = choice.keys.sample
  puts "You picked #{choice[p_choice]} and computer picked #{choice[c_choice]}"

  if p_choice == c_choice
    puts "It's a tie."
  elsif p_choice == "p" && c_choice == "r"
    puts "Paper wraps Rock!"
    puts "You won!"
  elsif p_choice == "p" && c_choice == "s"
    puts "Scissors cuts Paper!"
    puts "Computer won!"
  elsif p_choice == "r" && c_choice == "p"
    puts "Paper wraps Rock!"
    puts "Computer won!"
  elsif p_choice == "r" && c_choice == "s"
    puts "Rock smashes Scissor!"
    puts "You won!"
  elsif p_choice == "s" && c_choice == "p"
    puts "Scissors cuts Paper!"
    puts "You won!"
  elsif p_choice == "s" && c_choice == "r"
    puts "Rock smashes Scissor!"
    puts "Computer won!"
  end

  puts "Play again? (Y/N)"
  replay = gets.chomp.downcase
end while replay == 'y'
      