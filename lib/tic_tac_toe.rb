require 'pry'

class TicTacToe
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
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, value)
        @board[index] = value
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0, 8)
    end

    def turn_count
        @board.count { |position| position != " " }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter your desired position."
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.any? do |win_combo|
            return win_combo if position_taken?(win_combo[0]) && @board[win_combo[0]] == @board[win_combo[1]] && @board[win_combo[1]] == @board[win_combo[2]]
        end
    end

    def full?
       @board.all? { |position| position != " " }  
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if win_combo = won?
            @board[win_combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end