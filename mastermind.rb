
class Computer
  attr_reader :secret_code
  attr_accessor :pegs

  def initialize
  	generate_code
  	@pegs = ["-", "-", "-", "-"]
  end

  def generate_code
    colours = [1, 2, 3, 4, 5, 6, 7, 8]
    @secret_code = Array.new

    4.times do
      i = rand(0..colours.length-1)
      @secret_code << colours[i]
      colours.delete(colours[i])
    end
    @secret_code
  end
end

class Player
	attr_reader :won

	def initialize
		@won = false
	end

	def input_code
	  @player_code = Array.new
	  4.times do
	  	puts "Enter number: "
	  	number = gets.chomp
	  	@player_code << number.to_i
	  end
	  @player_code
	end

	def check_code(computer)
	  @player_code.each_with_index do |code, i|
	  	random_int = rand(0..3)
	  	if code == computer.secret_code[i]
	  		random_int = rand(0..3) while computer.pegs[random_int] != '-'
	  		computer.pegs[random_int] = 'X'
	  	elsif computer.secret_code.include?(code)
	  	  random_int = rand(0..3) while computer.pegs[random_int] != '-'
	  		computer.pegs[random_int] = 'O'
	  	end
	  end
	  puts @player_code.inspect
		#puts computer.secret_code.inspect
		puts computer.pegs.inspect
	  @won = true if computer.pegs == ["X", "X", "X", "X"]
	  computer.pegs = ["-", "-", "-", "-"]
	end
end

class Game
	def initialize
		@computer = Computer.new
		@player = Player.new
	end

	def play
		12.times do |i|
			puts "Round: #{i+1}"
			@player.input_code
			@player.check_code(@computer)
			if @player.won
				puts "You win"
				@computer = Computer.new
				@player = Player.new
				return
			end
		end
		puts "YOU LOSE, GOOD DAY SIR!"
	end
end

#game = Game.new
#game.play