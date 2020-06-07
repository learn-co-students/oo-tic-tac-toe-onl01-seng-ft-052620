# require "pry"
# binding.pry



class TicTacToe

    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    #user's input (a string) as an argument 
    def input_to_index(user_input)  
        #converts the user's input (a string) into an integer / would use .to_i
        #converts the user's input from the user-friendly format (on a 1-9 scale) to the array-friendly format (where the first index starts at 0) 
        user_input.to_i - 1
    end

    def move(i, user_turn)
        #allows "X" player in the top left and "O" in the middle
        @board[i] = user_turn
    end

    def position_taken?(index)
        if (@board[index] == " ") || (@board[index] == "") || (@board[index] == nil)
           return false 
        else
           return true
        end
     end

    def valid_move?(index)
        #returns true/false based on whether the position is already occupied
        # so a user chooses a space between the 0 - 8, and the position is NOT taken then they are good to go
        # both of those have to be true, so use &&
        if index.between?(0,8) && !position_taken?(index)
            true
        end
    end

    def turn_count
        #counts occupied positions
        turn = 0
        @board.each do |index|
            if index == "X" || index == "O"
                turn += 1
            end
        end
        turn
    end

    def current_player
        #returns the correct player, X, for the third move
        if turn_count.odd?
            return "O"
        else
            "X"
        end
    end

    def turn
        #Ask the user for their move by specifying a position between 1-9.
        #Receive the user's input.
        #Translate that input into an index value.
        # If the move is valid, make the move and display the board.
        # If the move is invalid, ask for a new move until a valid move is received.
        puts "Pick a number 1-9"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            player_token = current_player
            move(index, player_token)
            display_board
        else
            turn
        end
    end

    def  won?
        # returns false for a draw
        # returns the winning combo for a win
        # expect(game.won?).to contain_exactly(0,4,8)
        WIN_COMBINATIONS.each {|win_combo|
        index_0 = win_combo[0]
        index_1 = win_combo[1]
        index_2 = win_combo[2]
    
        position_1 = @board[index_0] #value of board at index_0 = win_combo[0]
        position_2 = @board[index_1]
        position_3 = @board[index_2]
    
        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return win_combo
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combo
        end
      }
      return false
    end
    
    def full?
        @board.all? {|i| i == "X" || i == "O"}
    end

    def draw?
        # returns true for a draw
        # returns false for a won game
        # returns false for an in-progress game
        if !won? && full?
            true
        else
            false
        end
    end

    def over?
        # returns true for a draw
        # returns true for a won game
        # returns false for an in-progress game
        if won? || draw?
            true
        else
            false
        end
    end

    def winner
        # return X when X won
        # returns O when O won
        # returns nil when no winner
        if won?
            @board[won?[0]]
        end
    end

    def play
        until over? == true
          turn
        end
      
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end
end