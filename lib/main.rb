# frozen_string_literal: true

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

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
p array
p array[3]
p array[3..array.length - 1]
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
tree.delete(26)
tree.pretty_print
p tree.find(3)
p tree.level_order
tree.level_order { |data| puts data.to_s }
p tree.height
p tree.level_order_rec
tree.level_order_rec { |data| puts data.to_s }
puts
p tree.in_order
tree.in_order { |data| puts data.to_s }
p tree.pre_order
tree.pre_order { |data| puts data.to_s }
p tree.post_order
tree.post_order { |data| puts data.to_s }
p tree.depth
p tree.balanced?
tree.insert(42)
p tree.height
p tree.balanced?
tree.insert(43)
tree.pretty_print
p tree.height
p tree.balanced?
tree.insert(4)
tree.pretty_print
p tree.height
p tree.balanced?
tree.insert(44)
tree.pretty_print
p tree.height
p tree.balanced?
tree.rebalance
tree.pretty_print

tree2 = Tree.new(Array.new(15) { rand(1..100) })
tree2.pretty_print
p tree2.balanced?
tree2.level_order_rec { |data| print "#{data} " }
puts
tree2.pre_order { |data| print "#{data} " }
puts
tree2.post_order { |data| print "#{data} " }
puts
tree2.in_order { |data| print "#{data} " }
puts
15.times { tree2.insert_recur(rand(101..200)) }
tree2.pretty_print
p tree2.balanced?
tree2.rebalance
tree2.pretty_print
p tree2.balanced?
tree2.level_order_rec { |data| print "#{data} " }
puts
tree2.pre_order { |data| print "#{data} " }
puts
tree2.post_order { |data| print "#{data} " }
puts
tree2.in_order { |data| print "#{data} " }
puts
