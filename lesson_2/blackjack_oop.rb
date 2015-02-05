class Game
  attr_accessor :player, :dealer, :deck
  CARD_VALUE = {"A" => 1, "1" => 1, "2" => 2, "3" => 3, "4" => 4,
                "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9,
                "10" => 10, "J" => 10, "Q" => 10, "K" => 10}
                
  def initialize(player, dealer)
    @player = Player.new(player)
    @dealer = Player.new(dealer)
    @deck = Deck.new
    @deck.shuffle!
  end

  def welcome_message
    puts "Welcome to Blackjack!"
  end

  def calc_hand(hand)
    total = 0

    hand.each do |card|
      total += CARD_VALUE[card[0]]
    end

    total = ace_value(hand, total)
  end

  def ace_value(hand, total)
    hand.each do |card|
      if card[0].include?('A')
        if total + 10 <= 21
          total += 10
        end
      end
    end
    total
  end

  def draw_hand(person)
    print "#{person.name} has: "
    person.hand.each do |card|
      print " #{card[0]}#{card[1]} "
    end
    print " for a total of " + calc_hand(person.hand).to_s
    puts ""
  end

  def hit_or_stay
    begin
      puts "Hit or stay? (h/s)"
      choice = gets.chomp.downcase
      if choice == 'h'
        player.hit(deck)
        draw_hand(player)
      elsif choice == 's'
        next
      else
        puts "Invalid input"
        next
      end
    end until choice == 's' or calc_hand(player.hand) > 21
  end

  def blackjack?(hand)
    calc_hand(hand) == 21 ? true : false
  end

  def compare_hand(player_total, dealer_total)
    if dealer_total > 21
      puts "DEALER BUSTED WITH #{dealer_total}! YOU WIN!"
    elsif dealer_total > player_total
      puts "DEALER HAS #{dealer_total}. YOU LOSE!"
    elsif dealer_total < player_total
      puts "YOU HAVE #{player_total} COMPARED TO DEALER'S #{dealer_total}. YOU WIN!"
    else
      puts "TIE WITH #{player_total}"
    end
  end

  def play_again
    puts "Do you wish to play again? (y/n)"
    answer = gets.chomp.downcase
    if answer == 'y'
      reset
    end
    answer
  end

  def reset
    self.deck = Deck.new
    self.deck.shuffle!
    player.hand = []
    dealer.hand = []
  end

  def play
    loop do
      system 'clear'
      welcome_message

      player.hit(deck)
      player.hit(deck)

      draw_hand(player)

      if blackjack?(player.hand)
        puts "BLACKJACK! #{player.name} wins!"
        continue = play_again
        if continue == 'y'
          next
        else
          break
        end
      end

      hit_or_stay
      player_hand_total = calc_hand(player.hand)

      if player_hand_total > 21
        puts "BUSTED! YOU LOSE!"
        continue = play_again
        if continue == 'y'
          next
        else
          break
        end
      end

      dealer.hit(deck)
      dealer.hit(deck)

      if blackjack?(dealer.hand)
        draw_hand(dealer)
        puts "BLACKJACK! #{dealer.name} wins!"
        continue = play_again
        if continue == 'y'
          next
        else
          break
        end
      end

      while calc_hand(dealer.hand) < 16 or calc_hand(dealer.hand) < player_hand_total
        dealer.hit(deck)
      end

      draw_hand(dealer)

      compare_hand(player_hand_total, calc_hand(dealer.hand))

      continue = play_again
      if continue == 'y'
        next
      else
        break
      end
    end
  end

end

class Player
  attr_accessor :name, :hand
  def initialize(name)
    @name = name
    @hand = []
  end

  def hit(deck)
    self.hand.push deck.deal
  end
end

class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    ['A', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'].each do |rank|
      ['H', 'C', 'S', 'D'].each do |suits|
        @deck << Card.new(rank, suits)
      end
    end
  end

  def deal
    deck.pop.card
  end

  def shuffle!
    deck.shuffle!
  end

end

class Card
  attr_accessor :card

  def initialize(rank, suits)
    @card = [rank, suits]
  end
end

Game.new('Bob', 'Dealer').play
