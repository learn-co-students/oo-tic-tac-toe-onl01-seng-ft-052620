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

    def valid_move?(index) 
        if !position_taken?(index) && index.between?(0,8)
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

    def won? 
        WIN_COMBINATIONS.each do |winner|
          return winner if winner.all? {|index| @board[index] == "X"}
        end
        WIN_COMBINATIONS.each do |winner|
            return winner if winner.all? {|index| @board[index] == "O"} 
        end
		false
    end

    def full?
        if @board.any? {|i| i == " "}
            false
        else 
            true
        end
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        WIN_COMBINATIONS.each do |winner|
            return "X" if winner.all? {|index| @board[index] == "X"}
            end
        WIN_COMBINATIONS.each do |winner|
              return "O" if winner.all? {|index| @board[index] == "O"} 
              end
        nil
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end

    

end