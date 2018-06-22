class Queue
  def initialize
    @queue_array = []
  end

  def enqueue(el)
    @queue_array.push(el)
    el
  end

  def dequeue
    @queue_array.shift()
  end

  def peek
    @queue_array.first
  end

end
