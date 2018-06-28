

def sluggish_octopus(array)
  longest = array.first
  array.each_with_index do |el,i|
    (i+1...array.length).each do |j|
      if array[j].length > longest.length
        longest = array[j]
      end
    end
  end
  longest
end

def dominant_octopus(list)
  prc = Proc.new {|x,y| y.length <=> x.length}
  list.merge_sort(&prc)[0]
end

def clever_octopus(list)
  # longest = list.first
  list.reduce do |longest, el|
    if el.length > longest.length
      el
    end
  end

end

class Array
  def merge_sort( &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return self if length <=1

    mid_idx = length/2
    left = self.take(mid_idx).merge_sort
    right = self.drop(mid_idx).merge_sort

    Array.merge(left,right, &prc)

  end

  def self.merge(left,right, &prc)

    sorted = []
    until left.empty? || right.empty?
      case prc.call(left.first,right.first)
      when -1
        sorted << left.shift
      when 0
        sorted << left.shift
      when 1
        sorted << right.shift
      end
    end

    sorted.concat(left)
    sorted.concat(right)
    sorted
  end
end

#tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(move,tiles_array)
  tiles_array.each_with_index do |direction,i|
    if move == direction
      return i
    end
  end
end

tiles_hash = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7
}

def constant_dance(move, tiles_hash)
  tiles_hash[move]
end
