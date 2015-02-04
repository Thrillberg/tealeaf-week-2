class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end
end

class Player
  attr_accessor :hand, :name, :wins

  def initialize
    @name = "The computer"
    @wins = 0
    @hand = ""
  end

  def to_s
    "#{@name} currently has a choice of #{Game::CHOICES[self.hand.value]}."
  end

end

class Human < Player
  
  def initialize
    super
    puts "What is your name?"
    self.name = gets.chomp
  end
  
  def pick_hand
    begin
      puts "Pick one: (p, r, s):"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)

    self.hand = Hand.new(c)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  CHOICES = { 'p' => 'paper', 'r' => 'rock', 's' => 'scissors' }

  attr_accessor :player, :computer, :results_player,
  :results_computer, :round_count, :number_of_rounds, :name

  def initialize
    @player = Human.new
    @computer = Computer.new
    @results_player = []
    @results_computer = []
    @round_count = 0
    @number_of_rounds = 3
  end

  def is_numeric?(obj) 
    obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def how_many_rounds
    begin
      puts "How many rounds would you like to play?"
      @number_of_rounds = gets.chomp
    end until is_numeric?(@number_of_rounds)
  end

  def compare_hands
    puts player.to_s
    puts computer.to_s
    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      puts "#{player.name} won!"
      player.wins += 1
    else
      puts "The computer won!"
      computer.wins += 1
    end
  end

  def play
    how_many_rounds
    while round_count.to_i != number_of_rounds.to_i do
      player.pick_hand
      computer.pick_hand
      compare_hands
      @round_count += 1
    end
    puts""
    puts "You won #{player.wins} game(s)."
    puts "The computer won #{computer.wins} game(s)."
    if player.wins > computer.wins
      puts "Congratualtions, you won!"
    elsif computer.wins > player.wins
      puts "Sorry, the computer won."
    elsif player.wins == computer.wins
      puts "It's a tie."
    else
      puts "Something went wrong..."
    end
    puts "Thanks for playing!"
   
  end

end

game = Game.new.play