require 'pry'

class TicTacToe
    
    WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    def initialize
        @board = Array.new(9," ")
    end

    def display_board()
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index,token)
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count()
        @board.count {|token| token == 'X' || token == 'O'}
    end

    def current_player()
        self.turn_count() % 2 == 0 ? 'X' : 'O'
    end

    def turn

        while true
            puts "Enter a move (1-9): "
            input = self.input_to_index(gets.strip)
            if valid_move?(input)
                self.move(input,self.current_player())
                break
            end
            puts "Invalid move. Try again."
        end
        self.display_board()
    end

    def won?
        WIN_COMBINATIONS.each do |win|
            if position_taken?(win[0])
                token = @board[win[0]]
                if @board[win[1]] == token && @board[win[2]] == token
                    return win
                end
            end
        end
        return false
    end

    def full?
        self.turn_count()==9
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.won? || self.draw?
    end

    def winner
        if self.won?
            self.turn_count() % 2 == 0 ? 'O' : 'X'
        else 
            nil
        end
    end

    def play
        while !self.over?
            self.turn()
        end

        if self.won?
            puts "Congratulations #{self.winner()}!"
        else 
            puts "Cat's Game!"
        end
    end
end