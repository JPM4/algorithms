# This is nice from a time complexity standpoint, with O(1) insert,
# remove, and include?, but is severely restrictive as to what it can
# contain (only integers up to the max number specified). It also takes
# up space relative to the max number as opposed to the number of
# elements it "contains".

class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
    @count = 0
    @max = max
  end

  def count
    @count
  end

  def insert(el)
    return false if el > @max || include?(el)
    @store[el] = true
    @count += 1

    true
  end

  def remove(el)
    return false if el > @max || !include?(el)
    @store[el] = false
    @count -= 1

    true
  end

  def include?(el)
    @store[el]
  end
end
