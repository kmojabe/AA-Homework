class Map
  def initialize
    @map_array = []
  end

  def set(key,value)
    unless key_exists?(key)
      @map_array.push([key,value])
    else
      @map_array.each_with_index do |arr,idx|
        @map_array[idx] = [key,value] if arr.first == key
      end
    end
  end

  def key_exists?(key)
    return false if @map_array.length == 0
    @map_array.any? { |pair| pair.first == key  }
  end

  def get(key)
    key_value = @map_array.select { |arr| arr.first == key }
    return key_value.first.last if key_value
    nil
  end

end
