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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end