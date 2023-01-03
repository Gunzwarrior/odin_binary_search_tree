require_relative 'node'

a1 = Node.new(1, 2, 3)
a2 = Node.new(4, 5, 6)
a3 = Node.new(7, 8, 9)

p a1
p a2
p a1 < a2
p a1 < a3
p a3 < a1