class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups = Array.new(14) {Array.new}
    (0..5).each do |i|
      @cups[i] += [:stone,:stone,:stone,:stone]
    end
    (7..12).each do |i|
      @cups[i] += [:stone,:stone,:stone,:stone]
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    i = start_pos + 1
    until stones.empty?
      i += 1 if (i == 13) && (current_player_name == @name1)
      i += 1 if (i == 6) && (current_player_name == @name2)

      i = 0 if i > 13

      @cups[i] << stones.pop
      i+=1
    end
    render
    next_turn(i-1)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 13 || ending_cup_idx == 6
      return :prompt
    elsif @cups[i=ending_cup_idx].length <= 1
      return :switch
    else
      ending_cup_idx
    end
        
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    bottom = (0..5).all? { |idx| @cups[idx].empty?  }
    top = (7..12).all? { |idx| @cups[idx].empty?  }
    return true if bottom || top
    false
  end

  def winner
    player1_points = @cups[6].length
    player2_points = @cups[13].length

    case player1_points <=> player2_points
    when -1 
      return @name2
    when 0
      return :draw
    when 1
      return @name1
    end
  end
end
