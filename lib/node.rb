class Node
  include Comparable
  attr_accessor :data
  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end
  def <=>(other)
    data <=> other.data
  end
end