require "00a_static_array"

class CircularBuffer
  attr_reader :capacity, :store, :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @offset = 0
  end

  def [](index)
    if index > (length - 1)
      raise "index out of bounds"
    else
      @store[(@offset + index) % @capacity]
    end
  end

  def []=(index, value)
    @store[(@offset + index) % @capacity] = value
  end

  def push(el)
    @length += 1
    resize! if @length > @capacity
    self[@length - 1] = el
  end

  def pop
    raise "index out of bounds" if @length == 0
    popped = self[@length - 1]
    @length -= 1

    popped
  end

  def unshift(el)
    @length += 1
    resize! if @length > @capacity
    @offset = (@offset - 1) % capacity
    self[0] = el
  end

  def shift
    raise "index out of bounds" if length == 0
    shifted = self[0]
    @length -= 1
    @offset = (@offset + 1) % @capacity

    shifted
  end

  private

  def resize!
    new_capacity = @capacity * 2
    @store_new = StaticArray.new(new_capacity)
    length.times { |idx| @store_new[idx] = self[idx] }

    @capacity = new_capacity
    @store = @store_new
  end
end
