defmodule Merge do

  def sort(l) when length(l) < 2 do
    l
  end

  def sort(l) do

    {l1, l2} = split(l)
    l1 = sort(l1)
    l2 = sort(l2)

    merge(l1, l2)
  end

  def split(l) do
    split(l, [], [])
  end
  def split([h|t], res1, res2) when length(res1) <= length(res2) do
    split(t, [h|res1], res2)
  end
  def split([h|t], res1, res2) when length(res1) > length(res2) do
    split(t, res1, [h|res2])
  end
  def split([], res1, res2) do
    {res1, res2}
  end

  def merge([h1|t1]=l1,[h2|t2]=l2) do
    case less(h1,h2) do
      ^h1 ->
        [h1|merge(t1, l2)]
      ^h2 ->
        [h2|merge(t2, l1)]
    end
  end
  def merge([], em) do
    em
  end
  def merge(em, []) do
    em
  end

  def less(a,b) do
    cond do
      a <= b ->
        a
      b < a ->
        b
    end
  end

end
