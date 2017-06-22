require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new{|x,y| x <=> y}
  end

  def count
    @store.count
  end

  def extract
    raise "no element to extract" if count == 0

    # swap the root with the last node
    @store = self.class.swap_nodes(0, @store.length - 1, @store)

    # pop the last node
    extracted_value = @store.pop

    # heaify_down the new root to keep the heap property
    self.class.heapify_down(@store, 0, @store.length, &prc)

    extracted_value
  end

  def peek
    raise "heap is empty" if @store.empty?
    @store.first
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, @store.length-1, @store.length, &@prc)
  end



  protected
  attr_accessor :prc, :store




  public
  def self.child_indices(len, parent_index)

    result = []

    [1, 2].each do |shift|
      possible_child_index = (2 * parent_index) + shift
      result << possible_child_index if possible_child_index < len
    end

    result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.find_swap_child_idx(child_indices_array, array, prc)
    return child_indices_array.first if child_indices_array.length == 1

    if prc.call(array[child_indices_array.first], array[child_indices_array.last]) == -1
      return child_indices_array.first
    else
      child_indices_array.last
    end
  end

  def self.swap_nodes(idx1, idx2, array)
    array[idx1], array[idx2] = array[idx2], array[idx1]
    array
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x,y| x <=> y }

    return array if child_indices(len, parent_idx).empty?

    child_indices_array = child_indices(len, parent_idx)
    swap_child_idx = find_swap_child_idx(child_indices_array, array, prc)

    new_array = array
    if prc.call(array[swap_child_idx], array[parent_idx]) == -1
      new_array = swap_nodes(parent_idx, swap_child_idx, array)
    end

    return heapify_down(new_array, swap_child_idx, new_array.length, &prc)
  end



  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x,y| x <=> y }

    # done if at the root or the child/parent relationship satisfies heap property
    if child_idx == 0 || prc.call(array[child_idx], array[parent_index(child_idx)]) == 1
      return array
    end

    parent_index = parent_index(child_idx)

    new_array = swap_nodes(child_idx, parent_index, array)

    return heapify_up(new_array, parent_index, new_array.length, &prc)

  end
end
