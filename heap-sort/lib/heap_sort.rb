require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new

    until self.empty?
      heap.push(self.pop)
    end


    until heap.count == 0
      self.push(heap.extract)
    end

  end
end
