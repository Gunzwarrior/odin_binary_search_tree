require_relative 'node'

class Tree
  def initialize(array)
    @root = build_tree(clean_array(array))
  end
  def build_tree(array)
    return nil if array == []

    mid = (array.length)/2
    left = array[0...mid]
    right = array[mid+1..array.length-1]
    p "mid is #{mid} left is #{left} right is #{right}"

    Node.new(array[mid], build_tree(left), build_tree(right))

  end
  def clean_array(array)
    array.sort!.uniq!
  end

  def insert(value)
    pointer = @root
    second_pointer = pointer
    until pointer.nil?
      return "#{value} already exist in the tree" if value == pointer.data

      second_pointer = pointer
      if value < pointer.data
        pointer = pointer.left
      else
        pointer = pointer.right
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
    elsif
      root.data > value
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
        until temp.left.nil?
          temp = temp.left
        end
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
      unless node.nil?
        if block_given?
          yield node.data
        else
          array.push(node.data)
        end
        queue.push(node.left, node.right)
      end
    end
    array unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end