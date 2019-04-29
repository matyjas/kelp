defmodule Tree.NodeTest do
  use ExUnit.Case

  alias Tree.Node, as: N
  
  test "node has a nil value" do
    node = %N{}
    assert node.value == nil
  end

  test "node has edges" do
    node = %N{edges: [%N{},%N{}]}
    refute node.edges == nil
    assert is_list(node.edges)
  end
end
