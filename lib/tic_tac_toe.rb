require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5], # Middle row
        [6,7,8], # Bottom row
        [0,3,6], # First column
        [1,4,7], # Second column
        [2,5,8], # Third column
        [0,4,8], # Left to Right diag
        [2,4,6] # Right to Left diag
        # et cetera, creating a nested array for each win combination
    ]


    def initialize
      @board = Array.new(9, " ")
    end
   
    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end
   
    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end
   
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        sys_input = user_input.to_i
        sys_input -= 1
        sys_input
    end

    def move(index, token = "X")

        @board[index] = token

    end

    def position_taken?(user_input)

        !@board[user_input].include?(" ")

    end
    
    def valid_move?(position)
        if position >= 0 && position <= 8
            !position_taken?(position)
        else
            false
        end
    end

    def turn
       

        puts "Give me value from 1-9 \n"
        position = gets.chomp
        index = input_to_index(position)
        
        if valid_move?(index)
            token = current_player
            move(index, token)
            display_board
        else
            puts "Another number, between 1-9 \n"
            position = gets.chomp
        end

       


    end

    def won?
        

        WIN_COMBINATIONS.find do |indexs|
            values = @board.values_at(*indexs)
            values.all?("X") || values.all?("O")
            
        end

    end

    def full?
        @board.all?{|value| value == 'X' || value == 'O' }  
    end

    def draw?
        full? && !won?
    end

    def over?
        full? || won? || draw?
    end

    def winner
        if won?
            if current_player == "O"
                "X"
            elsif current_player == "X"
                "O"
            end
        end
    end

    def play

        display_board

        while !self.over? 
            self.turn
            
        end


        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end

       


    end

  end