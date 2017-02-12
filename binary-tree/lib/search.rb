require_relative "node"

class Search
  attr_accessor :root

  def initialize(array=[])
    @root = nil
    build_tree(array) if array.length > 0
  end

  def build_tree(array)
    @root = Node.new(array.pop)
    array.each do |elem|
      child = Node.new(elem)
      place_child(@root, child)
    end
  end

  private

  def place_child(parent, child)
    if child.value < parent.value
      if parent.left_child.nil?
        left_child_nil(parent, child)
      else
        place_child(parent.left_child, child)
      end
    elsif child.value > parent.value
      if parent.right_child.nil?
        right_child_nil(parent, child)
      else
        place_child(parent.right_child, child)
      end
    else
      if parent.left_child.nil?
        left_child_nil(parent, child)
      elsif parent.right_child.nil?
        right_child_nil(parent, child)
      else
        place_child(parent.left_child, child)
      end
    end
  end

  def left_child_nil(parent, child)
    parent.left_child = child
    child.parent = parent
  end

  def right_child_nil(parent, child)
    parent.right_child = child
    child.parent = parent
  end
end
