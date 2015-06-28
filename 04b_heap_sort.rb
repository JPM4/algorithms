require_relative '03_heap'

class Array
  def heap_sort_1!
    # Using O(n) space by creating a separate heap first

    heap = BinaryMinHeap.new
    self.each do |el|
      heap.push(el)
    end

    self.each_index do |idx|
      self[idx] = heap.extract
    end
  end

  def heap_sort_2!
    # Uses O(1) space.

    2.upto(count).each do |size|
      BinaryMinHeap.heapify_up(self, size - 1, size)
    end

    count.downto(2).each do |size|
      self[size - 1], self[0] = self[0], self[size - 1]
      BinaryMinHeap.heapify_down(self, 0, size - 1)
    end

    self.reverse!
  end
end

fail unless [6, 3, 4, 5, 1, 2].heap_sort_1! == [1, 2, 3, 4, 5, 6]
fail unless [6, 3, 4, 5, 1, 2].heap_sort_2! == [1, 2, 3, 4, 5, 6]

fail unless [1, 4, 7, 2, 5, 8, 9, 3, 6, 0].heap_sort_1! == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
fail unless [1, 4, 7, 2, 5, 8, 9, 3, 6, 0].heap_sort_2! == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

fail unless [0, 9, 4, 7, 2, 5, 3, 6, 1].heap_sort_1! == [0, 1, 2, 3, 4, 5, 6, 7, 9]
fail unless [0, 9, 4, 7, 2, 5, 3, 6, 1].heap_sort_2! == [0, 1, 2, 3, 4, 5, 6, 7, 9]
