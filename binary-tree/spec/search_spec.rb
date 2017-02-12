require "spec_helper"
require "node"
require "search"

RSpec.describe Search do
  let(:array) { [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324] }
  let(:search) { described_class.new(array) }
  let(:root) { search.root }

  describe "#build_tree" do
    it "assigns a value to the root" do
      expect(root.value).to eq(324)
    end

    it "assigns smaller value to left_child" do
      expect(root.left_child.value).to eq(1)
    end

    it "assigns larger value to right_child" do
      expect(root.right_child.value).to eq(6345)
    end

    it "assigns parent as previous node" do
      expect(root.right_child.parent).to eq(root)
    end

    it "assigns multiple children" do
      expect(root.left_child.right_child.value). to eq(7)
    end

    it "assigns child with same value to the left" do
      expect(root.left_child.right_child.left_child.left_child.value).to eq(4)
    end
  end
end
