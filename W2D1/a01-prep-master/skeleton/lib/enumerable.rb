class Array

	def my_each(&block)
		self.length.times {|i| block.call(self[i])}
		self
	end

	def my_select(&block)
		result = []
		self.my_each do |el|
			result << el if block.call(el)
		end
		result
	end

	def my_reject(&block)
		result = []

		self.my_each do |el|
			result << el unless block.call(el)
		end
		result
	end

	def my_flatten
		#return an array  
		return self if self.length == 1

		result = []

		self.each do |el|
			if el.is_a?(Array)
				result += (el.my_flatten)
			else
				result << el
			end
		end
		p result
	end

	def my_zip(*inputs)
		result = []
		self.each_with_index do |el,idx|
			idx_arr = [el]
			inputs.each do |arr|
				idx_arr << arr[idx]
			end
			result << idx_arr
		end
		result

	end

	def my_rotate(num = 1)
		self.drop(num) + self.take(num)

	end

	def bubble_sort(&block)
		block ||= Proc.new {|x,y| x <=> y }
		arr = self.dup
		self.length.times do |i|
			self.length.times do |j|
				case block.call(arr[i],arr[j])
				when -1
					arr[i],arr[j] = arr[j],arr[i]
				end
			end
		end
		arr
	end

	def bubble_sort!(&block)
		block ||= Proc.new {|x,y| x <=> y }
		#arr = self.dup
		self.length.times do |i|
			self.length.times do |j|
				case block.call(self[i],self[j])
				when -1
					self[i],self[j] = self[j],self[i]
				end
			end
		end
		self
	end

end

def factors(num)
	(1..num).select {|i| num % i == 0}

end

def subwords(word, dictionary = nil)
	unless dictionary
		dictionary = Hash.new(false)
	 	dictionary = {
	 		"cat" => true,
	 		"fat" => true,
	 		"at" => true,
	 		"phic" => true
	 	}
	end 
	result = []
	word.length.times do |i|
		j=i
		until j >= word.length
			subword = word[i..j].downcase
			if dictionary[subword]
				result << subword
			end
			j+=1
		end
	end
	result
end

