class BinaryMinHeap
  attr_reader :store

  def initialize
    @store = []
  end

  def push(el)
    @store << el
    BinaryMinHeap.heapify_up(@store, @store.length - 1)
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)

    val
  end

  def self.child_indices(size, idx)
    c_indices = []
    child1 = (idx * 2) + 1

    c_indices << child1 if child1 < size
    c_indices << child1 + 1 if child1 + 1 < size

    c_indices
  end

  def self.parent_index(idx)
    raise "root has no parent" if idx == 0
    (idx - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    l_child_index, r_child_index = child_indices(len, parent_idx)

    parent_val = array[parent_idx]

    if l_child_index && (prc.call(array[l_child_index], parent_val) == -1)
      if r_child_index && (prc.call(array[r_child_index], array[l_child_index]) == -1)
        min_idx = r_child_index
      else
        min_idx = l_child_index
      end
    elsif r_child_index && (prc.call(array[r_child_index], parent_val) == -1)
      min_idx = r_child_index
    else
      return array
    end

    array[min_idx], array[parent_idx] = parent_val, array[min_idx]

    heapify_down(array, min_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0
    parent_idx = parent_index(child_idx)

    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    else
      return array
    end

    heapify_up(array, parent_idx, len, &prc)
  end
end
