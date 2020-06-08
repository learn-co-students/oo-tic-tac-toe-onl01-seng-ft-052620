require 'pry'

class TicTacToe
    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2], #top row
        [3,4,5], #middle row
        [6,7,8], #bottom row
        [2,4,6], #left right diagonal
        [0,4,8], #right left diagonal
        [0,3,6], #left column
        [1,4,7], #middle column
        [2,5,8] #right column
    ]

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

    def move(input, token = "X")
        @board[input] = token
    end

    def position_taken?(input)
        @board[input].include?("X") || @board[input].include?("O")
    end

    def valid_move?(pos)
        !position_taken?(pos) && pos.between?(0,8)
        #position_taken returns true if spot is taken, we want to 
        # know if its not taken so we use !. pos is the already passed thru
        # index so we use 0 - 8
    end

    def turn
        puts "Please choose a number 1-9."
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            puts "Please enter a valid move"
            turn
        end
        display_board
    end

    def turn_count
        counter = 0 
        @board.each do |index|
            if index == "X" || index == "O"
                counter += 1
            end
        end
        counter
    end

    def current_player
        if turn_count.even?
            "X"
        else
            "O"
        end
    end

    def won?
        WIN_COMBINATIONS.each {|combo|
        index_0 = combo[0]
        index_1 = combo[1]
        index_2 = combo[2]

        pos_1 = @board[index_0]
        pos_2 = @board[index_1]
        pos_3 = @board[index_2]

        if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
            return combo
        elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
            return combo
        end
        }
        false
    end

    def full?
        turn_count == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        # binding.pry
        draw? || won?
    end

    def winner
        winning_combo = []
        winning_combo = won?
        if winning_combo == false
            nil
        else
            if @board[winning_combo[0]] == "X"
                "X"
            else
                "O"
            end
        end
    end

    def play
        # binding.pry
        until over?
            # binding.pry
            turn
        end
        if won? != false
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end