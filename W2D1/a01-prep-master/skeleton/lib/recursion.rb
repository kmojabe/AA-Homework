# def permutations(arr)
# 	return [arr] if arr.length <= 1
# 	arr = arr.dup

# 	result = []
# 	first = arr.shift
# 	perm = permutations(arr)

# 	perm.each do |curr_arr|
# 		(0..curr_arr.length).each do |i|
# 			result << curr_arr[0...i] + [first] + curr_arr[i..-1]
# 		end
# 	end

# 	result
# end
def range(num1,num2)
	return [num2] if num2 == num1
	#result = [num2]
	result = range(num1,num2-1)
	result += [num2]
end

def exponentiation(base, exponent)
	return 1 if exponent == 0

	base * exponentiation(base,exponent-1)
end

class Array

	def deep_dup
		return self.dup if self.length <=1
		duplicate = []
		self.each do |el|
			if el.is_a?(Array)
				duplicate << el.deep_dup
			else
				duplicate << el
			end
		end
		duplicate
	end
end

#[1,2,3] => [1,2,3], [1,3,2], [2,1,3], [2,3,1], etcc

def permutations(array)
	return [array] if array.length <= 1
	#arr = arr.dup

	first = array.shift
	perms = permutations(array)
	result = []

	perms.each do |arr|
		(0..arr.length).each do |i|
			result << arr[0...i] + [first] + arr[i..-1]
		end
	end
	result
end

def fibonacci(num)
	return [1,1] if num <=1

	fib = fibonacci(num-1)
	[fib.first+fib[1]] + fib
end

def binary_search(arr, target)
	#block ||= Proc.new {|x,y| x <=> y}
	
	return nil if arr.empty?
	mid_idx = arr.length/2

	left = arr[0...mid_idx]
	right = arr[mid_idx+1..-1]

	case target <=> arr[mid_idx]
	when -1
		binary_search(arr.take(mid_idx),target)
	when 0
		mid_idx
	when 1
		roger = binary_search(right,target)
		if roger == nil
			return nil
		else
			return mid_idx + 1 + roger
		end
	end
end

class Array
	
	# def quick_sort
	# 	return self if self.length <= 1
	# 	first = self.first
	# 	left = []
	# 	right = []

	# 	pivot_idx=0
	# 	(1...self.length).each do |j|
	# 		if self[j] <= first
	# 			left << self[j]
	# 		else
	# 			right << self[j]
	# 		end
	# 	end

	# 	sort_left = left.quick_sort
	# 	sort_right = right.quick_sort
	# 	sort_left + [first] + sort_right

	# end

end

def quick_sort(array, &block)
	block ||= Proc.new {|x,y| x <=> y}
	return array if array.length <= 1

	pivot = array.first
	left = []
	right = []

	(1...array.length).each do |i|
		case block.call(array[i],pivot)
		when -1
			left << array[i]
		else
			right << array[i]
		end
	end
	left_sort = quick_sort(left, &block)
	right_sort = quick_sort(right, &block)

	left_sort + [pivot] + right_sort

end

def merge_sort()

