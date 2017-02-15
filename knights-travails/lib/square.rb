class Square
  attr_accessor :x, :y, :parent, :children

  def initialize(x, y, parent = nil)
    @x = x
    @y = y
    @parent = parent
    @children = [] #in this version it is more difficult to compare children by value and thus arrange
    #into left and right child. Therefore, storing the children into an array is an easier arrangement.
  end

  def make_children
    candidates = []
    candidates.push([x + 2, y + 1], [x + 1, y + 2], [x - 2, y - 1],
      [x - 1, y - 2], [x + 2, y - 1], [x + 1, y - 2], [x - 2, y + 1],
      [x - 1, y + 2]) #this preselects the potential moves that a knight can make.
    children = candidates.select { |cand| cand[0] >= 0 && cand[0] <= 7 &&
      cand[1] >=0 && cand[1] <= 7 } #this removes all moves that are ineligible (be out of bounds).
    @children = children.map { |child| Square.new(child[0], child[1], self) }
    #this returns the eligible moves as a set of instances of the square class, to allow call back to parents
    #via self.
  end
end

def search(root, value)
  queue = [root] #stores start value into a queue array
  loop do
    curr = queue.shift #removes the first element from the queue.
    return curr if curr.x == value.x && curr.y == value.y #if final value is the element removed, returns it.
    curr.make_children.each { |child| queue << child } #else, it pushes the children of current element
    #on to the queue for further search, and repeats with the next element in the queue.
  end
end

def route(start, finish)
  start_obj = Square.new(start[0], start[1])
  end_obj = Square.new(finish[0], finish[1])
  result = search(start_obj, end_obj)

  route = [[end_obj.x, end_obj.y]]
  curr = result.parent
  until curr == nil #until back at the root who has no parent(nil)
    route.unshift([curr.x, curr.y]) #keep adding x and y value to route list
    curr = curr.parent #go to the parents parent
  end
  route.each { |square| p square }
end
