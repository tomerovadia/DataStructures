require 'byebug'
require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    linked_list = bucket(key)
    if linked_list.include?(key)
      linked_list.update(key, val)
    else
      resize! if @count == num_buckets
      linked_list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    linked_list = bucket(key)
    linked_list.get(key)
  end

  def delete(key)
    linked_list = bucket(key)
    linked_list.remove(key)

    @count -= 1
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2, LinkedList.new)
    self.each do |k, v|
      new_store[k.hash % (num_buckets * 2)].append(k, v)
    end

    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end


end
