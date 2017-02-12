class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value=nil)
    @value = value
    @parent = nil
    @left_child = nil
    @right_child = nil
  end
end
