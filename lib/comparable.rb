module Comparable
  def same_type?(node1, node2)
    return true if node1.data.class == node2.data.class

    false
  end
end