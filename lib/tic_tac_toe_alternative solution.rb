require 'pry'

class TicTacToe

    # define a board at the creation of an instance.
    def initialize
    @board = Array.new(9, " ")
    @turns = 0
    end

    # create scenarios where the instance can recognize the winner
    WIN_COMBINATIONS = [
        [0, 4, 8],
        [1, 4, 7],
        [0, 3, 6],
        [2, 4, 6],
        [2, 5, 8],
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
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

    def move(index, token = "X")
        @board[index] = token
        @turns += 1
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        if index < 0 || index >= 9 || position_taken?(index)
            false
        else
            true
        end
    end

    def turn
        puts "Plese enter 1 - 9"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index)
            self.display_board
            self.current_player
        else puts "Sorry, that move is invalid. Please enter a new number."
            self.turn
        end
    end

    def turn_count
        @turns
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    
    def pattern(player)
        pattern = []
        @board.each_with_index do |value, index|
            pattern << index if value == "#{player}"
        end
        pattern   
    end

    def won?
        winning_pattern = nil

        pattern_x = self.pattern("X")
        pattern_o = self.pattern("O")
        WIN_COMBINATIONS.each do |pattern|
            x = pattern[0]
            y = pattern[1]
            z = pattern[2]
            if pattern_x.include?(x) && pattern_x.include?(y) && pattern_x.include?(z)
                winning_pattern = pattern
            elsif pattern_o.include?(x) && pattern_o.include?(y) && pattern_o.include?(z)
                winning_pattern = pattern
            end
        end
        winning_pattern
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