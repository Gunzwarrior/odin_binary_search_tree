require_relative 'node'
require_relative 'tree'

a1 = Node.new(1, 2, 3)
a2 = Node.new(4, 5, 6)
a3 = Node.new(7, 8, 9)

array = []
p array == []

p a1
p a2
p a1 < a2
p a1 < a3
p a3 < a1

tree = Tree.new([1, 2, 7, 6, 45, 89, 3, 45, 26, 45, 89, 6, 7, 5, 9, 12])

p tree

array = [1,2,3, 4, 5, 6, 7, 8, 9]
p array
p array[3]
p array[3..array.length-1]
array.pop
array.pop
array.pop
p array
p array[0]
puts
tree.pretty_print
tree.insert(13)
tree.insert(7)
tree.pretty_print
tree.insert_recur(46)
tree.pretty_print