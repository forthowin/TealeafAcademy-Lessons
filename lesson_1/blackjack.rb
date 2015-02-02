
def hand_total(hand)
  total = 0
  hand.each do |card|
    total += CARDS[card]
  end

  total = ace_value(hand, total)
end

def ace_value(hand, total)
  hand.each do |card|
    if card.include?('Ace')
      if total + 10 <= 21
        total += 10
      end
    end
  end
  total
end

def print_hand(hand)
  hand.each { |card| print "|#{card}|  "}
  puts ""
end

def hit(hand, deck)
  card = deck.sample
  hand.push(card)
  deck.delete(card)
end

def play_again
  puts "Do you wish to play again? (y/n)"
  gets.chomp.downcase
end

def initialize_deck
  deck = ["Ace of Clubs", "Ace of Diamonds", "Ace of Hearts", "Ace of Spades",
          "2 of Clubs", "2 of Diamonds", "2 of Hearts", "2 of Spades",
          "3 of Clubs", "3 of Diamonds", "3 of Hearts", "3 of Spades",
          "4 of Clubs", "4 of Diamonds", "4 of Hearts", "4 of Spades",
          "5 of Clubs", "5 of Diamonds", "5 of Hearts", "5 of Spades",
          "6 of Clubs", "6 of Diamonds", "6 of Hearts", "6 of Spades",
          "7 of Clubs", "7 of Diamonds", "7 of Hearts", "7 of Spades",
          "8 of Clubs", "8 of Diamonds", "8 of Hearts", "8 of Spades",
          "9 of Clubs", "9 of Diamonds", "9 of Hearts", "9 of Spades",
          "10 of Clubs", "10 of Diamonds", "10 of Hearts", "10 of Spades",
          "Jack of Clubs", "Jack of Diamonds", "Jack of Hearts", "Jack of Spades",
          "Queen of Clubs", "Queen of Diamonds", "Queen of Hearts", "Queen of Spades",
          "King of Clubs", "King of Diamonds", "King of Hearts", "King of Spades"]
end

CARDS = {"Ace of Clubs" => 1,    "Ace of Diamonds" => 1,    "Ace of Hearts" => 1,    "Ace of Spades" => 1,
         "2 of Clubs" => 2,      "2 of Diamonds" => 2,      "2 of Hearts" => 2,      "2 of Spades" => 2,
         "3 of Clubs" => 3,      "3 of Diamonds" => 3,      "3 of Hearts" => 3,      "3 of Spades" => 3,
         "4 of Clubs" => 4,      "4 of Diamonds" => 4,      "4 of Hearts" => 4,      "4 of Spades" => 4,
         "5 of Clubs" => 5,      "5 of Diamonds" => 5,      "5 of Hearts" => 5,      "5 of Spades" => 5,
         "6 of Clubs" => 6,      "6 of Diamonds" => 6,      "6 of Hearts" => 6,      "6 of Spades" => 6,
         "7 of Clubs" => 7,      "7 of Diamonds" => 7,      "7 of Hearts" => 7,      "7 of Spades" => 7,
         "8 of Clubs" => 8,      "8 of Diamonds" => 8,      "8 of Hearts" => 8,      "8 of Spades" => 8,
         "9 of Clubs" => 9,      "9 of Diamonds" => 9,      "9 of Hearts" => 9,      "9 of Spades" => 9,
         "10 of Clubs" => 10,    "10 of Diamonds" => 10,    "10 of Hearts" => 10,    "10 of Spades" => 10,
         "Jack of Clubs" => 10,  "Jack of Diamonds" => 10,  "Jack of Hearts" => 10,  "Jack of Spades" => 10,
         "Queen of Clubs" => 10, "Queen of Diamonds" => 10, "Queen of Hearts" => 10, "Queen of Spades" => 10,
         "King of Clubs" => 10,  "King of Diamonds" => 10,  "King of Hearts" => 10,  "King of Spades" => 10}

begin
  system 'clear'
  player_hand = []
  dealer_hand = []
  deck = initialize_deck

  puts "Welcome to Blackjack"
  puts "You have been dealt:"

  hit(player_hand, deck)
  hit(player_hand, deck)

  print "Your hand: ====> "
  print_hand(player_hand)

  if hand_total(player_hand) == 21
    puts "Blackjack! YOU WON!"
    continue = play_again
    next
  end

  begin
    puts "Hit or stay? (h/s)"
    choice = gets.chomp.downcase
    if choice == 'h'
      hit(player_hand, deck)
      print "Your hand: ===> "
      print_hand(player_hand)
    elsif choice == 's'
      next
    else
      puts "Invalid input"
      next
    end
  end until choice == 's' or hand_total(player_hand) > 21

  player_total = hand_total(player_hand)

  if player_total > 21
    puts "#{player_total} BUSTED! YOU LOSE!"
    continue = play_again
    next
  end

  hit(dealer_hand, deck)
  hit(dealer_hand, deck)

  while hand_total(dealer_hand) < 16 or hand_total(dealer_hand) < player_total
    hit(dealer_hand, deck)
  end

  print "Dealer's hand: ===> "
  print_hand(dealer_hand)

  dealer_total = hand_total(dealer_hand)

  if dealer_total > 21
    puts "DEALER BUSTED WITH #{dealer_total}! YOU WIN!"
  elsif dealer_total > player_total
    puts "DEALER HAS #{dealer_total}. YOU LOSE!"
  elsif dealer_total < player_total
    puts "YOU HAVE #{player_total} COMPARED TO DEALER'S #{dealer_total}. YOU WIN!"
  else
    puts "TIE WITH #{player_total}"
  end

  continue = play_again
end until continue == 'n'
