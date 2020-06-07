class TicTacToe
attr_accessor :board

def initialize
  @board = Array.new(9, " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

def display_board
	puts " #{board[0]} | #{board[1]} | #{board[2]} "
	puts "-----------"
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
	puts "-----------"
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i-1
end

def move(index, current_player)
  if current_player == "O"
    board[index] = "O"
  else
    board[index] = "X"
  end
end

def position_taken?(index)
  if board[index] == nil
    return false
  elsif
    board[index] == " "
    return false
  elsif
    board[index] == ""
    return false
  else
    return true
  end
end

def valid_move?(index)
    if index < 0 || index > 8
      return false
    elsif
    position_taken?(index) == true
      return false 
    else
      return true
    end 
end

def turn
  puts "Player, please enter a number between 1 and 9."
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index, current_player)
  else
    turn
  end
  display_board
end

def turn_count
  board.count("X") + board.count("O")
end

def current_player
  turn_count % 2 == 0 ? "X" : "O"
end

def won?
  WIN_COMBINATIONS.each do | combo |
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" 
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end 
  false
end

def full?
  board.all? { |space| space == "X" || space == "O" }
end

def draw?
  if full? == true && won? == false
    return true
  elsif won? == true
    return false
  else
    return false
  end
end

def over?
  if full? == true || won? == true
    return true
  else
    return false
  end 
end

def winner
  if won?
    win = board[won?[0]]
  win
  end
end

def play
  if !over?
      turn
  elsif won?
      puts "Congratulations #{winner}!" 
  elsif draw?
      puts "Cats Game!" 
  end
end

end