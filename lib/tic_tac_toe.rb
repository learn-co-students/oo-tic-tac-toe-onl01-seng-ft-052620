require 'pry'

class TicTacToe
 
 def initialize
  @board = Array.new(9, " ")
end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
    
    def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i-1
  end
  
  def move(index, current_player = "X")
    @board[index] = current_player
  end
  
  def position_taken?(index)
    if (@board[index] == " " || @board[index] == "" || @board[index] == nil)
       false
    else
        true
  end
  end
  
  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
 end
 
 def turn
   puts "Choose a number between 1-9:"
   input = gets.strip
   index = input_to_index(input)
   if valid_move?(index)
      move(index, current_player)
    else
      puts "Invalid input. Please try again."
      turn
   end
   display_board
 end
 
 def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
 
 def current_player
   turn_count % 2 == 0 ? "X" : "O"
end

def won?
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
    
    position_1 = @board[win_index_1]
    position_2 = @board[win_index_2]
    position_3 = @board[win_index_3]
   
   if position_taken?(win_index_1) && (position_1 == position_2 && position_1 == position_3)
      return combo
    end
end
  return false
end

 def full?
    @board.all?{|i| i != " " }
  end

  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      return @board[won?[0]]
    end
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end