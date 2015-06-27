class MergeSort
  def self.merge(arr1, arr2, &prc)
    prc ||= Proc.new { |val1, val2| val1 <=> val2 }

    idx1 = 0
    idx2 = 0
    merged = []
    until idx1 == arr1.length || idx2 == arr2.length
      if prc.call(arr1[idx1], arr2[idx2]) < 1
        merged << arr1[idx1]
        idx1 += 1
      else
        merged << arr2[idx2]
        idx2 += 1
      end
    end

    if idx1 == arr1.length
      return merged + arr2[idx2..-1]
    else
      return merged + arr1[idx1..-1]
    end
  end

  def self.sort(arr, &prc)
    return arr if arr.length < 2
    mid = arr.length / 2
    merge(sort(arr[0...mid], &prc), sort(arr[mid..-1], &prc), &prc)
  end
end
