
class TicTacToe 
  
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5], 
  [6,7,8], 
  [0,4,8], 
  [6,4,2],
  [0,3,6], 
  [1,4,7], 
  [2,5,8]
  
  ]
  
  def initialize 
    @board = Array.new(9, " ")
  end 
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    input.to_i - 1 
  end 
  
  def move(index, token="X")
    @board[index] = token 
  end 

def position_taken?(position)
    @board[position] == "X" || @board[position] == "O"
  end 
  
  def valid_move?(position)
     !position_taken?(position) && position.between?(0, 8)
  end 
  
  def turn_count 
    count = 0 
    @board.each do |i| 
      count += 1 if i == "X" || i == "O" 
    end 
    count 
  end 
  
  def current_player 
    turn_count.even? ? "X" : "O"
  end 
  
  def turn 
    puts "Enter a number between 1-9"
    choice = gets.strip 
    pos = input_to_index(choice)
    if valid_move?(pos) 
      move(pos, current_player)
      display_board 
    else 
      turn 
    end 
  end 
  
  def won? 
    WIN_COMBINATIONS.select do |combo|
    pos1 = @board[combo[0]]
    pos2 = @board[combo[1]]
    pos3 = @board[combo[2]]
    if pos1 == 'X' && pos2 == 'X' && pos3 == "X"
      return combo 
    elsif pos1 == 'O' && pos2 == 'O' && pos3 == "O"
      return combo 
    end 
    end
    false 
  end
  
  def full?
    @board.all?{|i| i != " " && i != nil}
  end 
  
  def draw?
    full? && !won?
  end 
  
  def over?
    draw? || won?
  end 
  
  def winner
    combo = won?
    if combo 
      if combo.all? {|i| @board[i] == "X"}
        "X"
      elsif combo.all? {|i| @board[i] == "O"}
        "O"
      end 
    end
  end 
  
  def play 
    while !over? 
      turn 
    end 
    if won? 
      puts "Congratulations #{winner}!"
    else 
      puts "Cat's Game!"
    end 
  end 
  
  

  
end 