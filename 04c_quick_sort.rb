class QuickSort
  def self.partition(arr, start_idx, len, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx = start_idx
    pivot = arr[start_idx]
    ((start_idx + 1)...(start_idx + len)).each do |idx|
      val = arr[idx]
      if prc.call(val, pivot) < 1
        arr[idx] = arr[pivot_idx + 1]
        arr[pivot_idx + 1] = pivot
        arr[pivot_idx] = val

        pivot_idx += 1
      end
    end

    pivot_idx
  end

  def self.sort2!(arr, start_idx = 0, len = arr.length, &prc)
    return arr if len < 2

    pivot_idx = partition(arr, start_idx, len, &prc)

    left_len = pivot_idx - start_idx
    right_len = len - (left_len + 1)
    sort2!(arr, start_idx, left_len, &prc)
    sort2!(arr, pivot_idx + 1, right_len, &prc)

    arr
  end
end
