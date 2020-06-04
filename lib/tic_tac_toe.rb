class TicTacToe
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

	def initialize
		@board = Array.new(9, " ")
		@turn_count = 0
	end

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
	end

	def position_taken?(index)
		@board[index] != " "
	end

	def valid_move?(index)
		Array.new(9){|index| index}.include?(index) && !position_taken?(index)
	end

	def turn
		print "What's your move? (select a position between 1-9): "
		position = gets
		position_index = input_to_index(position) 

		unless valid_move?(position_index) 
			print "That's not a valid move. Please enter a postion between 1-9 that isn't already taken: "
			position = gets
			position_index = input_to_index(position) 
		end
		
		move(position_index, current_player)
		display_board
	end

	def turn_count
		@board.count{|position| position != " "}
	end

	def current_player
		turn_count.even? ? "X" : "O"
	end

	def winning_ary?(ary)
		x_indices = @board.map.with_index{|token, i| i if token == "X"}.compact
		o_indices = @board.map.with_index{|token, i| i if token == "O"}.compact
		ary.all?{|i| x_indices.include?(i)} || ary.all?{|i| o_indices.include?(i)}
	end

	def won?
		winning_ary = false
		WIN_COMBINATIONS.each do |win_ary|
			winning_ary = win_ary if winning_ary?(win_ary)
		end
		winning_ary
	end

	def full?
		!@board.include?(" ")
	end

	def draw?
		full? && !won?
	end

	def over?
		draw? || won?
	end

	def winner
		(turn_count.odd? ? "X" : "O") if won?
	end

	def play
		while !over? 
			turn
		end

		if won?
			puts "Congratulations #{winner}!"
		elsif draw?
			puts "Cat's Game!"
		end
	end
end

