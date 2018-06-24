class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @game_over = false
    @seq = []
    #add_random_color
    @sequence_length = 1

  end

  def play
    until @game_over
      take_turn
    end 
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    user_guess = require_sequence
    if good_guess?(user_guess)
      round_success_message
    else
      @game_over = true
    end
  end

  def good_guess?(user_guess)
    idx = -1
    @seq.all? {|el| el == user_guess[idx += 1]}
  end

  def show_sequence
    add_random_color
    @sequence_length.times do |i|
      puts "#{i}: #{@seq[i]}"
      sleep(1.25)
      system('clear')
    end
  end

  def require_sequence
    puts "Guess the #{@sequence_length.to_s} color sequence: (e.g. red green blue etc)"
    user_guess = gets.chomp.split(" ")
  end

  def add_random_color
    rand_number = rand(4)
    @seq << COLORS[rand_number]
    @sequence_length = @seq.length
  end

  def round_success_message
    @sequence_length += 1
    puts "Good Memory!!\nYou advance to level #{@sequence_length}"

  end

  def game_over_message
    puts "Game Over You Made it to Level #{@sequence_length}"
  end

  def reset_game
    @game_over = false
    @seq = []
    @sequence_length = 1

  end
end
