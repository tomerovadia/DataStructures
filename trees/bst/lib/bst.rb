require 'byebug'

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end




class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if root.nil?
      self.root = BSTNode.new(value)
    else
      self.class.insert!(root, value)
    end
  end

  def find(value)
    self.class.find!(root, value)
  end

  def inorder
    self.class.inorder!(root)
  end

  def postorder
    self.class.postorder!(root)
  end

  def preorder
    self.class.preorder!(root)
  end

  def height
    self.class.height!(root)
  end

  def min
    self.class.min(root)
  end

  def max
    self.class.max(root)
  end

  def delete(value)
    self.class.delete!(root, value)
  end


  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?

    if value > node.value
      node.right = insert!(node.right, value)
    else
      node.left = insert!(node.left, value)
    end

    node
  end


  def self.find!(node, value)
    return nil if node.nil?
    return node if node.value == value

    if value < node.value
      return find!(node.left, value)
    else
      find!(node.right, value)
    end

  end

  def self.preorder!(node)
    return [] if node.nil?
    return [node.value] if node.left.nil? && node.right.nil?

    [node.value] + preorder!(node.left) + preorder!(node.right)
  end


  def self.inorder!(node)
    return [] if node.nil?
    return [node.value] if node.left.nil? && node.right.nil?

    inorder!(node.left) + [node.value] + inorder!(node.right)
  end


  def self.postorder!(node)
    return [] if node.nil?
    return [node.value] if node.left.nil? && node.right.nil?

    postorder!(node.left) + postorder!(node.right) + [node.value]
  end


  def self.height!(node)
    return -1 if node.nil?
    return 0 if node.left.nil? && node.right.nil?

    [height!(node.left) + 1, height!(node.right) + 1].max
  end


  def self.max(node)
    return node if node.right.nil?

    max(node.right)
  end


  def self.min(node)
    return node if node.left.nil?

    min(node.left)
  end


  def self.delete_min!(node)
    return nil if node.nil? || node.left.nil?

    node.left = node.left.right if node.left.left.nil?

    delete_min!(node.left)
  end

  def self.delete!(node, value)
    return nil if node.nil? || (node.left.nil? && node.right.nil?)

    if value > node.value
      if value == node.right.value
        node.right = node.right.right
      else
        delete!(node.right, value)
      end
    else
      if value == node.left.value
        node.left = node.left.right
      else
        delete!(node.left, value)
      end
    end
  end

  nil
end
