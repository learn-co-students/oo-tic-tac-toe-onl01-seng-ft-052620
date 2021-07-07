require 'pry'

class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
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
      puts "-----------"
    end

    def input_to_index(user_input)
      user_input.to_i - 1
    end

    def move(position, player)
      @board[position] = player
    end

    def position_taken?(position)
      @board[position] == "X" || @board[position] == "O"
    end

    def valid_move?(valid)
      valid.between?(0,8) && !position_taken?(valid)
    end

    def turn_count
      @board.count{|x| x == "X" || x == "O"}
    end

    def current_player
      if turn_count % 2 == 0
        "X"
      else
        "O"
      end
    end

    def turn
      current = current_player
      puts "#{current}, please enter a number 1-9:"
      input = gets.chomp
      index = input_to_index(input)
      if valid_move?(index)
        move(index, current)
        display_board
      else
        turn
      end
    end

    def won?
      WIN_COMBINATIONS.find do |x|
          @board[x[0]] == @board[x[1]] && @board[x[1]] == @board[x[2]] && position_taken?(x[0])
      end
    end

    def full?
      @board.all?{|x| x != " "}
    end

    def draw?
      if !won? && full?
        return true
      else
        return false
      end
    end

    def over?
      if won? || draw?
        return true
      else
        return false
      end
    end

    def winner
      congrats = won?
      # binding.pry
      if congrats
        @board[congrats[0]]
      end
    end

    #  until the game is over
    #     take turns
    #   end
    #
    #   if the game was won
    #     congratulate the winner
    #   else if the game was a draw
    #     tell the players it ended in a draw
    def play
      until over?
        turn
      end
      if won?
        puts "Congratulations #{winner}!"
      else draw?
        puts "Cat's Game!"
      end
    end

end
