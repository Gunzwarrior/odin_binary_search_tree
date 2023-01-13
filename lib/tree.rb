# frozen_string_literal: true

require_relative 'node'

# Tree class to construct a binary tree
class Tree
  def initialize(array)
    @root = build_tree(clean_array(array))
    @array = []
  end

  def build_tree(array)
    return nil if array == []

    mid = array.length / 2
    left = array[0...mid]
    right = array[mid + 1..array.length - 1]
    Node.new(array[mid], build_tree(left), build_tree(right))
  end

  def clean_array(array)
    sorted_array = array.sort
    sorted_array.uniq
  end

  def insert(value)
    pointer = @root
    second_pointer = pointer
    until pointer.nil?
      return "#{value} already exist in the tree" if value == pointer.data

      second_pointer = pointer
      pointer = if value < pointer.data
                  pointer.left
                else
                  pointer.right
                end
    end
    second_pointer.right = Node.new(value) if value > second_pointer.data
    second_pointer.left = Node.new(value) if value < second_pointer.data
  end

  def insert_recur(value, root = @root)
    return Node.new(value) if root.nil?

    if root.data == value
      root
    elsif root.data < value
      root.right = insert_recur(value, root.right)
    else
      root.left = insert_recur(value, root.left)
    end
    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if root.data < value
      root.right = delete(value, root.right)
    elsif root.data > value
      root.left = delete(value, root.left)
    else
      return nil if root.left.nil? && root.right.nil?

      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      else
        temp = root.right
        temp = temp.left until temp.left.nil?
        root.data = temp.data
        root.right = delete(temp.data, root.right)
      end
    end
    root
  end

  def find(value, root = @root)
    return root if root.nil? || root.data == value

    if root.data < value
      find(value, root.right)
    elsif root.data > value
      find(value, root.left)
    else
      root
    end
  end

  def level_order
    queue = []
    queue.push(@root)
    array = []
    until queue == []
      node = queue.shift
      next if node.nil?

      if block_given?
        yield node.data
      else
        array.push(node.data)
      end
      queue.push(node.left, node.right)
    end
    array unless block_given?
  end

  def level_order_rec(&block)
    h = height
    (1..h + 1).each do |i|
      current_level_order_rec(i, block)
    end
    to_return = @array
    @array = []
    to_return
  end

  def current_level_order_rec(level, block, root = @root)
    return if root.nil?

    if level == 1
      if block.nil?
        @array.push(root.data)
      else
        block.call root.data
      end
    else
      current_level_order_rec(level - 1, block, root.left)
      current_level_order_rec(level - 1, block, root.right)
    end
  end

  def height(root = @root)
    return -1 if root.nil?

    lheight = height(root.left)
    rheight = height(root.right)

    return lheight + 1 if lheight > rheight

    rheight + 1
  end

  def depth(root = @root)
    height - height(root)
  end

  def in_order(root = @root, array = [], &block)
    return if root.nil?

    in_order(root.left, array, &block)
    if block.nil?
      array.push root.data
    else
      block.call root.data
    end
    in_order(root.right, array, &block)
    array if block.nil?
  end

  def pre_order(root = @root, array = [], &block)
    return if root.nil?

    if block.nil?
      array.push root.data
    else
      block.call root.data
    end
    pre_order(root.left, array, &block)
    pre_order(root.right, array, &block)
    array if block.nil?
  end

  def post_order(root = @root, array = [], &block)
    return if root.nil?

    post_order(root.left, array, &block)
    post_order(root.right, array, &block)
    if block.nil?
      array.push root.data
    else
      block.call root.data
    end
    array if block.nil?
  end

  def balanced?(root = @root)
    return true if root.nil?

    lheight = height(root.left)
    rheight = height(root.right)
    return false if (lheight - rheight) > 1 || (lheight - rheight) < -1

    balanced?(root.left)
    balanced?(root.right)
  end

  def rebalance
    @root = build_tree(in_order)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
