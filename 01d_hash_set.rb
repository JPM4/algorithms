# This relies on objects having their own "hash" methods. If you were
# creating objects that you would be putting into a hash set, you would
# need to add a hash method to that object.

class HashSet
  attr_reader :count, :buckets

  def initialize
    @buckets = []
    8.times { @buckets << [] }
    @count = 0
  end

  def insert(el)
    return false if include?(el)
    @buckets[el.hash % @buckets.length] << el
    @count += 1
    resize! if @count > @buckets.length
    true
  end

  def include?(el)
    @buckets[el.hash % @buckets.length].each do |num|
      return true if el == num
    end

    false
  end

  def remove(el)
    @buckets[el.hash % @buckets.length].each_with_index do |num, idx|
      if el == num
        @buckets[el.hash % @buckets.length].delete_at(idx)
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
      bucket.each do |element|
        new_buckets[element.hash % new_length] << element
      end
    end
    @buckets = new_buckets
  end
end
