class Game
  attr_accessor :player, :turn, :move
  
  def initialize
    @my_board = Board.new
    @my_board.print_board
    @player = Human.new
    @computer = Computer.new
    @move = nil
  end
  
  def play
    until @my_board.board_full? == true || @my_board.winner? == true
      @move = @player.pick_move(@my_board)
      @my_board.play_a_move(@move, "X")
      if @my_board.board_full? == false && @my_board.winner? == false
        @move = @computer.pick_move(@my_board)
        @my_board.play_a_move(@move, "O")
      elsif @my_board.board_full? == true && @my_board.winner? == false
        puts "It's a tie!"
      end
    end
  end

end

class Player
  attr_accessor :spaces
end

class Human < Player
  def pick_move(some_old_board)
    puts "Please enter a number from 1..9"
    move = gets.chomp.to_i
    while some_old_board.marker_at(move) == "X" || some_old_board.marker_at(move) == "O"
      puts "Please enter a number from 1..9"
      move = gets.chomp.to_i
    end
    return move
  end
end

class Computer < Player
  def pick_move(some_old_board)
    move = some_old_board.two_in_a_row(some_old_board)
    if move == nil
       move = [*1..9].sample
    end
    while some_old_board.marker_at(move) == "X" || some_old_board.marker_at(move) == "O"
      move = [*1..9].sample
    end
    return move
  end
end

class Board
  def initialize
    @spaces = []
    (1..9).each{|position| @spaces[position] = ' '}
  end
  
  def print_board
    system 'clear'
    puts "     |     |     "
    puts "  #{@spaces[1]}  |  #{@spaces[2]}  |  #{@spaces[3]}  "  
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@spaces[4]}  |  #{@spaces[5]}  |  #{@spaces[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@spaces[7]}  |  #{@spaces[8]}  |  #{@spaces[9]}  "
    puts "     |     |     "
  end

  def play_a_move(position, marker)
    #position must be 1-9, marker must be 'X' or 'O'
    @spaces[position] = marker
    self.print_board
  end

  def marker_at(number)
    return @spaces[number]
  end

  def board_full?
    if @spaces.include?(" ")
      return false
    else
      return true
    end
  end

  def winner?
    result = nil
    winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    winning_lines.each do |line|
      if @spaces.values_at(*line).count('X') == 3 || @spaces.values_at(*line).count('O') == 3
        result = true
        if @spaces.values_at(*line).count('X') == 3
          puts "Congratualtions! You won!"
        elsif @spaces.values_at(*line).count('O') == 3
          puts "Sorry, the computer won."
        end
        break
      else
        result = false
      end
    end
    return result
  end

def two_in_a_row(board)
    winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    move = nil
    winning_lines.each do |line|
      if @spaces.values_at(*line).count('O') == 2 || @spaces.values_at(*line).count('X') == 2
        line.each do |boardIndex|
          if @spaces[boardIndex] == ' '
            move = boardIndex
          end
        end
      end
    end
    return move
  end

end

Game.new.play