require'pry'

class TicTacToe
  
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
  
  def initialize
    @board =  Array.new(9, " ")
  end
  
  def display_board
    puts(" #{@board[0]} | #{@board[1]} | #{@board[2]} ")
    puts("-----------")
    puts(" #{@board[3]} | #{@board[4]} | #{@board[5]} ")
    puts("-----------")
    puts(" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
  end
  
  def input_to_index(num)
    num.to_i-1
  end
  
  def move(index, token = "X")
    @board[index] = token
  end
  
  def position_taken?(index)
  @board[index] != " "
  end
  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
   
  def turn 
  puts "Please input number between 1-9:"
  user_input = gets.strip
    index = input_to_index(user_input)
    cp = current_player
    if valid_move?(index)
      move(index, cp)
    else
      turn
    end
  display_board
  end


  def turn_count
    counter = 0
    @board.each{|x| counter+=1 if x!=" "; }
    counter
  end
  
  def current_player
    turn_count.even? ? "X" : "O"
  end
  
  def won?
   WIN_COMBINATIONS.each do |win_combination|
    position_1 = @board[win_combination[0]]
    position_2 = @board[win_combination[1]]
    position_3 = @board[win_combination[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
       return win_combination
      elsif position_1 =="O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  nil  
end

def full?
9== @board.count{|position| position == "X" || position == "O"}
end

def draw? 
  !won? && full?
end

def over? 
  won? || full?
end

def winner
  if won? != false
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = @board[win_combination[0]]
    position_2 = @board[win_combination[1]]
    position_3 = @board[win_combination[2]]
    if position_1 == "X" && position_2 == "X" && position_3 == "X" 
      return "X"
      elsif position_1 =="O" && position_2 == "O" && position_3 == "O"
      return "O"
    end
  end
nil
end
end

def play 
  turn until over? || draw?
  puts draw? ? "Cat's Game!" : "Congratulations #{winner}!"
end

end
