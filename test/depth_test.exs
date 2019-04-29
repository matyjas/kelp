defmodule DepthTest do
  use ExUnit.Case, async: true

  alias Tree.Node, as: N
  import Depth

  test "first node is your node" do
    node = %N{value: :search_for_me, edges: [%N{},%N{}]}
    found = search(node, :search_for_me)
    assert found == node
  end

  test "return nil if node not found and there are no more edges" do
    node = %N{value: :not_what_im_looking_for}
    found = search(node, :droids)
    assert found == nil
  end
  
  test "return nil if node not found" do
    node = %N{value: :search_for_me, edges: [%N{},%N{}]}
    found = search(node, :something_else)
    assert found == nil
  end

  test "value in the edges" do
    node_to_find = %N{value: :search_for_me, edges: [%N{},%N{}]}
    node = %N{edges: [node_to_find]}
    found = search(node, :search_for_me)
    assert found == node_to_find
  end
  
  test "value two layers down" do
    node_to_find = %N{value: :layer_3}
    in_between = %N{value: :layer_2, edges: [node_to_find]}
    node = %N{value: :layer_1, edges: [in_between]}

    found = search(node_to_find, :layer_3)
    assert found == node_to_find

    found = search(in_between, :layer_3)
    assert found == node_to_find

    found = search(node, :layer_3)
    assert found == node_to_find
  end
  
  test "canonical example" do
    node_to_find = %N{value: :g, edges: [%N{value: :h}]}
    tree_with_b = %N{value: :b, edges: [%N{value: :d}, %N{value: :e}, %N{value: :f}]}
    node = %N{value: :a, edges: [tree_with_b, %N{value: :c, edges: [node_to_find]}]}
    found = search(node, :g)
    assert found == node_to_find
  end

  test "make sure it is depth first" do
    node_to_find = %N{value: :search_for_me}
    node_to_distract = %N{value: :search_for_me, edges: [%N{}]}

    layer_3 = %N{edges: [node_to_find]}
    layer_2 = %N{edges: [layer_3]}
    layer_1 = %N{edges: [layer_2]}

    node = %N{edges: [layer_1, node_to_distract]}
    found = search(node, :search_for_me)
    assert found == node_to_find
    assert found.edges == []
  end
  
  # testing seach_edges/2
  
  test "can search edges" do
    node_to_find = %N{value: :an_edge}
    found = search_edges([node_to_find], :an_edge)
    assert found == node_to_find
  end

  test "can search empty multi edge" do
    found = search_edges([], :impossible)
    assert found == nil
  end

  test "can search multi edges" do
    node_to_find = %N{value: :gold}
    found = search_edges([%N{}, %N{}, node_to_find, %N{}], :gold)
    assert found == node_to_find
  end
end
