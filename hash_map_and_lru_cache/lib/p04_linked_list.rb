class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.next.prev, self.prev.next = self.prev, self.next
  end
end











class LinkedList
  include Enumerable

  def initialize
    @head, @tail = Link.new, Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end

    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    @tail.prev.next = new_link
    new_link.prev = @tail.prev

    @tail.prev = new_link
    new_link.next = @tail

    return new_link
  end

  def update(key, val)
    each do |link|
      if link.key == key
        link.val = val
        return link
      end
    end

    return nil
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.remove
        return link
      end
    end

    nil
  end

  def each(&prc)
    current_link = @head.next
    while current_link != @tail
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
