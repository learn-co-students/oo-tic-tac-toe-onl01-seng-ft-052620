# frozen_string_literal: true

require 'pry'
class TicTacToe
  def initialize
    @board = Array.new(9, ' ')
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ].freeze
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(move)
    move = move.to_i
    move -= 1
  end

  def move(move, token = 'X')
    @board[move] = token
  end

  def position_taken?(move)
    @board[move] != ' '
  end

  def valid_move?(index)
    if (0..8).include?(index)
      !position_taken?(index)
    else
      false
    end
  end

  def turn_count
    count = @board.count { |num| num == 'X' || num == 'O' }

    count
  end

  def current_player
    current_player = (turn_count % 2).zero? ? 'X' : 'O'
    @winning_player = (turn_count % 2).zero? ? 'O' : 'X'
    current_player
  end

  def turn
    print 'Choose a position(1-9):'
    choice = gets.chomp
    move_index = input_to_index(choice)
    player = current_player
    if valid_move?(move_index)
      move(move_index, player)
      display_board
    else

      turn
    end
  end

  def won?
    x_winner = nil
    o_winner = nil
    WIN_COMBINATIONS.each do |winners|
      x_winner = winners  if winners.all? { |index| @board[index] == 'X' }
    end

    WIN_COMBINATIONS.each do |winners|
      o_winner = winners if winners.all? { |index| @board[index] == 'O' }
    end
    x_winner || o_winner
  end

  def full?
    @board.all? { |i| i != ' ' }
  end

  def draw?
    if full?
      false if won?
    end
    if full?
        true if !won?
    end
  end

  def over?
    if won?
      true
    else
      draw?
    end
  end

  def winner
    if won?
      current_player
      @winning_player
    end
  end

  def play
    until over?
        turn
    end
    if draw?
        puts "Cat's Game!"
    else winner
        puts "Congratulations #{@winning_player}!"
    end
  end
end

# The mostly elegent method
# def won?
#     WIN_COMBINATIONS.any? do |combo|
#       if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
#         return combo
#       end
#     end
#   end
