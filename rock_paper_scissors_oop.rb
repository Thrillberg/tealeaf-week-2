class Game
  attr_accessor :results1, :results2, :opponent_choice, :round_count, :number_of_rounds, :comp_choices, :player1_wins, :player2_wins
  def initialize
    @results1 = []
    @results2 = []
    @opponent_choice = 'a'
    @round_count = 0
    @number_of_rounds = 3
    @comp_choices = ["r", "p", "s"]
    @player1_wins = 0
    @player2_wins = 0
  end
  
  def play_a_round
    if round_count <= number_of_rounds
      player1_round
    
      if opponent_choice == 'a'
        player2_round_comp
      elsif opponent_choice == 'b'
        player2_round_human
      end
      @round_count += 1
      puts "Player 1 played #{results1}."
      puts "Player 2 played #{results2}."
      puts announce_round_winner
    end
  end
  
  def how_many_rounds
    puts "How many rounds would you like to play?"
    @number_of_rounds = gets.chomp.to_i
  end
  
  def human_or_comp
    puts "Would like you like to play against the computer or a friend?"
    puts "a) computer or b) friend"
    @opponent_choice = gets.chomp
    if opponent_choice == 'a'
      puts "You want to play a computer."
    elsif opponent_choice == 'b'
      puts "You want to play a friend."
    end
  end
      
  def player1_round
    puts "Player 1:"
    puts "(R)ock, (p)aper, or (s)cissors? Choose!"
    player1_choice = gets.chomp.downcase
    if player1_choice == "r"
    elsif player1_choice == "p"
    elsif player1_choice == "s"
    else
      puts "Invalid entry"
      player1_round
    end
    self.results1 << player1_choice
  end
  
  def player2_round_comp
    player2_choice = comp_choices.sample
    self.results2 << player2_choice
  end
  
  def player2_round_human
    puts "Player 2:"
    puts "(R)ock, (p)aper, or (s)cissors? Choose!"
    player2_choice = gets.chomp.downcase
    if player2_choice == "r"
    elsif player2_choice == "p"
    elsif player2_choice == "s"
    else
      puts "Invalid entry"
      player2_round
    end
    self.results2 << player2_choice
  end
    
  def announce_round_winner
    if self.results1[-1] == 'r' && self.results2[-1] == 's' ||
       self.results1[-1] == 'p' && self.results2[-1] == 'r' ||
       self.results1[-1] == 's' && self.results2[-1] == 'p'
      puts "Player 1 wins this round!"
      self.player1_wins += 1
    elsif self.results1[-1] == 'r' && self.results2[-1] == 'p' ||
       self.results1[-1] == 'p' && self.results2[-1] == 's' ||
       self.results1[-1] == 's' && self.results2[-1] == 'r'
      puts "Player 2 wins this round!"
      self.player2_wins += 1
    else
      puts "It's a tie!"
    end
  end
  
  def final_score
    if @player1_wins.to_i > @player2_wins.to_i
      puts "Player 1 won #{player1_wins} game(s) and player 2 won #{player2_wins} game(s)! Player 1 wins!"
    elsif @player1_wins.to_i < @player2_wins.to_i
      puts "Player 1 won #{player1_wins} game(s) and player 2 won #{player2_wins} game(s)! Player 2 wins!"
    else
      puts "Player 1 won #{player1_wins} game(s) and player 2 won #{player2_wins} game(s)! Both players are tied! Go home."
    end
  end
  
end

play_again = 'y'
until play_again == 'n'
  my_game = Game.new
  puts "Welcome to Rock, Paper, Scissors!"
  my_game.how_many_rounds
  my_game.human_or_comp
  puts my_game.opponent_choice
  while my_game.round_count < my_game.number_of_rounds
    my_game.play_a_round
  end
  my_game.final_score
  puts "Would you like to play again? (Y/N)"
play_again = gets.chomp.downcase
end