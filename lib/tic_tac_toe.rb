class TicTacToe
  
  #Class constant number placements on the board in nested arrays, minus reverse orders except 642(why?)
  WIN_COMBINATIONS = [[0,1,2], [0,4,8], [0,3,6], [1,4,7], [2,5,8], [3,4,5], [6,7,8], [6,4,2]]
  
  #Initialize board, x9 array defualt value nil
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
   
  # 3x3 rows made of the arrays from board, Separate with dash string. Interpoloated instance board variable by index for current state of board
  def display_board
  puts 'display board'
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end
  
  # User makes input, .to_i for index -1 for index rep ( one less than number scale)
  def input_to_index(u_input)
    u_input.to_i - 1 
  end 
  
  def move( position, cur)
    @board[position] = cur
  end
 
 # If inputted board index == X or O then true. (can you do reverse with "")
  def position_taken?(index)
   ((@board[index]) == "X") || (@board[index] == "O" )
  end
  
  # If postion_taken and index 0-8(input 1-9) return as true
  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end 
   
  # Counter start 0, iterate existing board, increment from last play
  def turn_count
    turn_number = 0 
    @board.each do |place|
      if place == "X" || place == "O"
        turn_number += 1 
      end 
    end 
    return turn_number
  end 
  
  # odds evens
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    cur = current_player
    if valid_move?(index)
      move(index, cur)
      display_board
    else
      turn
    end
  end
  
  
  def won?
  WIN_COMBINATIONS.detect do |win|
    if (@board[win[0]]) == "X" && (@board[win[1]]) == "X" && (@board[win[2]]) == "X"
      return win
    elsif (@board[win[0]]) == "O" && (@board[win[1]]) == "O" && (@board[win[2]]) == "O"
      return win
    end
      false
  end
end

  #all spaces negate value of empty string 
  def full?
    @board.all? {|no_space| no_space != " "}
  end
  
  # If board is full and theres  no winner
  def draw?
    full? && !won?
  end 
  
  # theres either a winner or a draw
  def over? 
    won? || draw?
  end 
  
  # way to use win? here to abstract code?
def winner
  WIN_COMBINATIONS.detect do |win|
    if (@board[win[0]]) == "X" && (@board[win[1]]) == "X" && (@board[win[2]]) == "X"
      return "X"
    elsif (@board[win[0]]) == "O" && (@board[win[1]]) == "O" && (@board[win[2]]) == "O"
      return "O"
    else
      nil
    end
  end
end

# game is not over, and no one has won. If theres a winner, put out winning message, same on draw
def play
  while over? == false
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
 end   
end