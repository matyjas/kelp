defmodule Depth do

  alias Tree.Node, as: N

  def search(node = %N{value: n_value}, value) when n_value == value, do: node

  def search(%N{edges: []}, _), do: nil

  def search(%N{edges: edges}, value), do: search_edges(edges, value)

  def search_edges([], _), do: nil

  def search_edges([head | tail], value) do
    case search(head, value) do
      x when x != nil -> x
      nil -> search_edges(tail, value)
    end
  end
end
