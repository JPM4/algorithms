class IntHashSet
  attr_reader :count, :buckets

  def initialize
    @buckets = []
    8.times { @buckets << [] }
    @count = 0
  end

  def insert(el)
    return false if include?(el)
    @buckets[el % @buckets.length] << el
    @count += 1
    resize! if @count > @buckets.length
    true
  end

  def include?(el)
    @buckets[el % @buckets.length].each do |num|
      return true if el == num
    end

    false
  end

  def remove(el)
    @buckets[el % @buckets.length].each_with_index do |num, idx|
      if el == num
        @buckets[el % @buckets.length].delete_at(idx)
        @count -= 1
        return true
      end
    end

    false
  end

  private

  def resize!
    new_length = @buckets.length * 2
    new_buckets = []
    new_length.times { new_buckets << [] }
    @buckets.each do |bucket|
      bucket.each do |num|
        new_buckets[num % new_length] << num
      end
    end
    @buckets = new_buckets
  end
end
