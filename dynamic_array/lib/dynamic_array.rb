require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless index < length
    self.store[index]
  end

  # O(1)
  def []=(index, value)
    self.store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0

    last_num = self.store[length - 1]
    self.store[length - 1] = nil
    self.length -= 1

    last_num
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible resize.
  def push(val)
    resize! if capacity == length

    store[length] = val
    self.length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0

    shifted_val = store[0]
    (1...length).each do |i|
      store[i - 1] = store[i]
    end

    self.length -= 1
    shifted_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if capacity == length

    (length - 1).downto(0) do |i|
      store[i + 1] = store[i]
    end

    store[0] = val

    self.length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if length == 0 || index >= length
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity == 0 ? self.capacity = 1 : self.capacity *= 2

    new_store = StaticArray.new(self.capacity)

    i = 0
    while i < length
      new_store[i] = store[i]
      i += 1
    end

    self.store = new_store
  end


end
