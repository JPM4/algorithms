require_relative "00a_static_array"

# This actually performs worse than Ruby's regular Array class;
# shift and unshift are both O(n) here, whereas Ruby arrays shift at
# O(1). The CircularBuffer implementation makes all operations O(1)
# amortized.

class DynamicArray
  attr_reader :capacity, :store, :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  def [](index)
    if index > (length - 1)
      raise "index out of bounds"
    else
      @store[index]
    end
  end

  def []=(index, value)
    @store[index] = value
  end

  def push(el)
    @length += 1
    resize! if @length > @capacity
    @store[@length - 1] = el
  end

  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[@length]
  end

  def unshift(el)
    @length += 1
    resize! if @length > @capacity
    idx = @length - 1
    idx.downto(1) do |i|
      @store[i] = @store[i - 1]
    end
    @store[0] = el
  end

  def shift
    raise "index out of bounds" if length == 0
    shifted = @store[0]
    (0...@length).each do |idx|
      @store[idx] = @store[idx + 1]
    end
    @length -= 1

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
