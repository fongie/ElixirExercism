defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Used recursion to take each element (head), apply the FUN function,
  and then in the next recursion call using the boolean to add the element to list or
  throw it away.
  Recursion ends when tail is empty ([])
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    list
    |> keep(fun, [])
  end

  defp keep([head | tail], fun, acc) do
    keep(
      tail,
      fun,
      if fun.(head) do acc ++ [head] else acc end
    )
  end

  defp keep([], fun, acc) do
    acc
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Same principle (and some duplicated code? Couldnt find a good way to use the previous keep
  methods for my discard one (!fun didnt work for example)
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    list
    |> discard(fun, [])
  end

  defp discard([head | tail], fun, acc) do
    discard(
      tail,
      fun,
      if !fun.(head) do acc ++ [head] else acc end
    )
  end

  defp discard([], fun, acc) do
    acc
  end
end
