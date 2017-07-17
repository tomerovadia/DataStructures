require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets

    bucket = self[key]

    (0...bucket.length).each do |i|
      return false if bucket[i] == key
    end

    bucket << key
    @count += 1
    true
  end

  def include?(key)
    bucket = self[key]

    (0...bucket.length).each do |i|
      return true if bucket[i] == key
    end

    false
  end

  def remove(key)
    bucket = self[key]

    (0...bucket.length).each do |i|
      if bucket[i] == key
        bucket.delete_at(i)
        @count -= 1
        return true
      end
    end

    false
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@count * 2, Array.new)

    old_store.flatten.each do |key|
      self[key] << key
    end
  end
end
