# This is just an exercise; almost entirely worthless as an
# efficient data structure. include? and remove are O(n).

class ArraySet
  def initialize
    @store = []
  end

  def count
    @store.count
  end

  def insert(el)
    return false if include?(el)
    @store << el

    true
  end

  def include?(el)
    @store.any? { |i| i == el }
  end

  def remove(el)
    return false unless include?(el)
    @store.delete(el)

    true
  end
end
