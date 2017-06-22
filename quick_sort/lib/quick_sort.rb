require 'byebug'

class QuickSort
  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot_idx = (0...array.length).to_a.sample
    pivot = array[pivot_idx]
    remainder = array.take(pivot_idx) + array.drop(pivot_idx + 1)

    smaller = []
    larger = []

    remainder.each do |num|
      num < pivot ? smaller << num : larger << num
    end

    sort1(smaller) + [pivot] + sort1(larger)
  end



  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new{|x,y| x <=> y }

    return if length <= 1

    pivot_idx = partition(array, start, length, &prc)

    sort2!(array, start, pivot_idx - start)
    sort2!(array, pivot_idx + 1, array.length - pivot_idx - 1)

    array
  end



  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|x,y| x <=> y }

    pivot = array[start]
    partition = start + 1

    (start + 1 ... start + length).each do |idx|
      if prc.call(pivot,array[idx]) == 1
        array[idx], array[partition] = array[partition], array[idx] unless partition == idx
        partition += 1
      end
    end

    array.delete_at(start)
    array.insert(partition - 1, pivot)

    partition - 1
  end
end

p QuickSort.sort2!([7,6,31,5,4,9,2,22,8,10,3,7])
