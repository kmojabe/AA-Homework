class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    @cache.length
    # returns number of elements currently in cache
  end

  def add(el)
    if @cache.include?(el)
      @cache.delete(el)
      @cache.unshift(el)
    elsif count >= @size
      @cache.pop
      @cache.unshift(el)
    else
      @cache.unshift(el)
    end
    # adds element to cache according to LRU principle
  end

  def show
    # shows the items in the cache, with the LRU item first
    p "[ " + cache.join(" ") + " ]"
    nil
  end


  private
  # helper methods go here!

end
