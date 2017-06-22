class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  # O(n)
  def insert(num)
    validate!(num)
    return false if @store[num]
    @store[num] = true
    true
  end

  def remove(num)
    validate!(num)
    return nil unless include?(num)
    @store[num] = false
    num
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    return false if num < 0
    !@store[num].nil?
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end




class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    (0..bucket.length).each do |i|
      return false if bucket[i] == num
    end
    bucket << num
    true
  end

  def remove(num)
    bucket = self[num]

    (0..bucket.length).each do |i|
      if bucket[i] == num
        bucket.delete_at(i)
        return true
      end
    end

    bucket << num
    true
  end

  def include?(num)
    bucket = self[num]
    (0..bucket.length).each do |i|
      return true if bucket[i] == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end




class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets

    bucket = self[num]

    (0...bucket.length).each do |i|
      return false if bucket[i] == num
    end

    bucket << num
    @count += 1
    true
  end

  def remove(num)
    bucket = self[num]

    (0...bucket.length).each do |i|
      if bucket[i] == num
        bucket.delete_at(i)
        @count -= 1
        return true
      end
    end

    false
  end

  def include?(num)
    bucket = self[num]

    (0...bucket.length).each do |i|
      return true if bucket[i] == num
    end

    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@count * 2, Array.new)

    old_store.flatten.each do |num|
      self[num] << num
    end
  end
end
