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
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(input, token)
        @board[input] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end

    def valid_move?(position)
        if @board[position] == " "
            true
        else
            false
        end
    end

    def turn_count
        c = 0
        @board.each do |index|
            if index == "X" || index == "O"
                c += 1
            end
        end
        c
    end

    def current_player
        if turn_count.even? == true
            "X"
        else
            "O"
        end
    end

    def turn
        puts "Please select your spot 1-9:"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            player = current_player
            move(index, player)
        else
           turn
        end
        display_board
    end

end