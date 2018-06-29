require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &block)
    accumulator = self.shift if accumulator.nil?
    #accumulator = [accumulator] if accumulator.is_a?(Fixnum)
    #result = []

    self.each_with_index do |el,i|
      accumulator = block.call(accumulator,el)
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return true if num == 1
  (2...num).all? {|i| (num % i) != 0}
end

def primes(num)
  result = []
  i=1
  until result.length == num
    result << i if is_prime?(i+=1)
  end
  result
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num <= 1

  result = factorials_rec(num-1)
  result << (num-1) * result[-1]

end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    final_hash = Hash.new { |hash, key| hash[key] =  [] }
    self.each_with_index {|el,i| final_hash[el] << i}
    final_hash.select { |k,v| v.length >= 2}
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    result = []

    self.length.times do |i|
      j = i
      until j == self.length
        string_eval = self[i..j]
        if (string_eval.reverse == string_eval) && (string_eval.length > 1)
          result << string_eval
        end
        j+=1
      end
    end

  result
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if self.length <= 1

    middle = self.length/2
    left = self[0...middle].merge_sort(&prc)
    right = self[middle..-1].merge_sort(&prc)
    Array.merge(left,right,&prc)
  end

  private
  def self.merge(left, right, &prc)

    prc ||= Proc.new { |x,y| x <=> y}

    result = []

    until left.length == 0 || right.length == 0
      case prc.call(left.first,right.first)
      when -1
        result << left.shift
      else
        result << right.shift
      end
    end

    return (result += right) if left.empty?
    return (result += left) if right.empty?
  end
end


