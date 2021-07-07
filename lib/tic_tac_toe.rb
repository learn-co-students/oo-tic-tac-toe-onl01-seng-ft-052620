class TicTacToe

    def initialize(board = nil)
        @board = board || Array.new(9, " ")

    end
        WIN_COMBINATIONS = [
            [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8],
            [0,4,8], [2,4,6]
        ]
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    def input_to_index(choice)
        @choice = choice.to_i - 1
        @choice
    end
    def move(input_to_index, token = "X")
        token == "X" || token == "O"
        @board[input_to_index] = token 
    end
    def position_taken?(input_to_index)
        if @board[input_to_index] == "X" ||@board[input_to_index] == "O"
            true
        else
            false
        end 
    end
    def valid_move?(place)
        !position_taken?(place) && place.between?(0,8)
    end

    def turn_count
        count = 0
        @board.each do |i| count += 1 if i =="X" || i == "O"
        end
        count
    end
    def current_player
        if turn_count % 2 == 0 
            token = "X"
        else
            token = "O"
        end
    end
    def turn 
        puts "enter a number between 1-9"
        choice = gets.strip
        position = input_to_index(choice)
        if valid_move?(position)
            move(position, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.select do |combo|
            spot1 = @board[combo[0]]
            spot2 = @board[combo[1]]
            spot3 = @board[combo[2]]
            if  spot1 == "X" && spot2 == "X" && spot3 == "X"
                return combo 
            elsif spot1 == "O" && spot2 == "O" && spot3 == "O"
                return combo

            end

        end
        false 
    end
    def full?
        @board.all?{|i| i != " " && i != nil}
    end
    def draw?
        full? && !won?
    end
    def over?
        draw? || won?
    end
    def winner
        combo = won?
        if combo
            if combo.all? {|i| @board[i] == "X"}
                "X"
            elsif combo.all? {|i| @board[i] == "O"}
                "O"
            end
        end
    end
    def play 
        while !over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end 
 