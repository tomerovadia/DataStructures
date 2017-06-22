require 'byebug'
require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(start_idx + index)

    store[index + start_idx]
  end

  # O(1)
  def []=(index, val)
    check_index(start_idx + index)

    store[index + start_idx] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0

    value, store[length - 1 + start_idx] = store[length - 1 + start_idx], nil

    self.length -= 1

    value
  end


  # O(1) ammortized
  def push(val)
    resize! if capacity == length

    store[(start_idx + length) % capacity] = val

    self.length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0

    value, store[start_idx] = store[start_idx], nil

    self.start_idx += 1
    self.length -= 1

    value
  end

  # O(1) ammortized
  def unshift(val)
    resize! if capacity == length

    store[(start_idx + capacity - 1) % capacity] = val

    self.start_idx -= 1
    self.length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if length == 0 || index >= length
      raise "index out of bounds"
    end
  end

  def resize!
    self.capacity = self.capacity == 0 ? 1 : self.capacity * 2

    new_store = StaticArray.new(self.capacity)

    (start_idx...start_idx + length).each do |i|
      new_store[i] = store[i]
    end

    self.store = new_store
  end
end
