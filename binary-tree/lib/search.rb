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

  def breadth_first_search(value)
    return nil if root == nil
    queue = [root]
    until queue.empty?
      node = queue.shift
      if node.value == value
        return node
      else
        queue.push(node.left_child) unless node.left_child.nil?
        queue.push(node.right_child) unless node.right_child.nil?
      end
    end
    nil
  end

  def depth_first_search(value)
    return nil if root == nil
    stack = [root]
    until stack.empty?
      first_element = stack[0]
      while stack.last.left_child != nil
        stack.push(stack.last.left_child)
      end
      while first_element == stack[0]
        node = stack.pop
        if node.value == value
          return node
        else
          stack.push(node.right_child) unless node.right_child.nil?
        end
      end
    end
    nil
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
