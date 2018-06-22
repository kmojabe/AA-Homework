class Stack

  def initialize
    @stack_array = []
  end

  def push(el)
    @stack_array.push(el)
  end

  def pop
    @stack_array.pop()
  end

  def peek
    @stack_array.last
  end

  def render
    p @stack_array
  end

end
