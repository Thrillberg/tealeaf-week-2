class Player
  
  attr_accessor :hand, :name
  
  def initialize(name)
    @name = name
    @hand = []
  end

  def blackjack?
    true if total_of_cards == 21
  end
  
  def total_of_cards
    result = 0
    
    include_ace = false
    
    @hand.each do |card|
      if card.value == '2'
        result += 2
      elsif card.value == '3'
        result += 3
      elsif card.value == '4'
        result += 4
      elsif card.value == '5'
        result += 5
      elsif card.value == '6'
        result += 6
      elsif card.value == '7'
        result += 7
      elsif card.value == '8'
        result += 8
      elsif card.value == '9'
        result += 9
      elsif card.value == '10' || card.value == 'Jack' || card.value == 'Queen' || card.value == 'King'
        result += 10
      elsif card.value == 'Ace'
        include_ace = true
        result += 11
      end  
    end
    
    if include_ace && result > 21
      result -= 10
    end
    result
  end
  
  def busted?
    true if total_of_cards > 21
  end
  
  def to_st
    result = ""
    @hand.each do |card| 
      result += card.to_st + ", "
    end
    result
  end
  
end

class Human < Player
  
  def initialize(name)
    super(name)
  end
  
  def hit?
    hit_or_stay = ""
    puts "Would you like to hit? (y/n)"
    hit_or_stay = gets.chomp.downcase
    until hit_or_stay == "y" || hit_or_stay == "n"
      puts "Please enter y or n!"
      hit_or_stay = gets.chomp.downcase
    end
    hit_or_stay
  end
end

class Dealer < Player
  def over_17?
    over_17 = false
    over_17 = false if total_of_cards <= 17
    over_17 = true if total_of_cards > 17
    over_17
  end
end

class Deck

  attr_accessor :cards

  def initialize
    @cards = []
    ['Heart', 'Diamond', 'Spade', 'Club'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    shuffle
  end
  
  def shuffle
    cards.shuffle!
  end
  
  def deal_a_card
    @cards.pop
  end
  
end

class Card

  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value = v
  end
 
  def to_st
    "the #{value} of #{suit}s"
  end
  
end

class Game # the game engine
  def initialize

  end
  
  def self.play_again?
    play_again = nil
    until play_again == "y" || play_again == "n"
      puts "Would you like to play again? (y/n)"
      play_again = gets.chomp.downcase
      if play_again == "y"
        return true
      elsif play_again == "n"
        return false
      end
    end
  end

  def play
    play_a_round
    while Game.play_again?
      play_a_round
    end
  end


  def play_a_round
    #while play_again == true 

    @human = Human.new("Eric")
    @computer = Dealer.new("R2D2")
    @deck = Deck.new
    
      # Human turn
      @human.hand << @deck.deal_a_card
      @human.hand << @deck.deal_a_card
      puts "Your hand is #{@human.to_st}for a total value of #{@human.total_of_cards}."
      if @human.blackjack?
          puts "Congratualtions! You hit blackjack!"
      end
      while @human.hit? == "y"
        @human.hand << @deck.deal_a_card
        puts "Your hand is #{@human.to_st} for a total value of #{@human.total_of_cards}."
        if @human.busted?
          puts "Sorry, you busted!"
          return
        end
      end

      # Computer turn
      @computer.hand << @deck.deal_a_card
      @computer.hand << @deck.deal_a_card
      puts "#{@computer.name} has been dealt two cards."
      puts "#{@computer.name}'s hand is #{@computer.to_st}for a total value of #{@computer.total_of_cards}."
    
      while @computer.over_17? == false
        @computer.hand << @deck.deal_a_card
        puts "#{@computer.name} hit and got another card. Now #{@computer.name}'s hand is #{@computer.to_st}."
        puts "#{@computer.name}'s total is now #{@computer.total_of_cards}."
      end

      if @computer.busted?
        puts "Congratulations! #{@computer.name} busted!"

      #Evaluate hands
      elsif @human.total_of_cards == @computer.total_of_cards
        puts "It's a tie!"
      elsif @human.total_of_cards > @computer.total_of_cards
        puts "Congratulations, you win!"
      else
        puts "Sorry, #{@computer.name} won."
      end
    end
end

Game.new.play