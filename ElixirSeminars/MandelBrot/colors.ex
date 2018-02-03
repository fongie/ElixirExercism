defmodule Colors do

  # Converts a depth to a rgb color
  def convert(depth, max) do
    frac = depth / max
    a = frac*4
    x = trunc(a)
    y = trunc(255*(a-x))

    case x do
      0 ->
        {:rgb,y,0,0}
      1 ->
        {:rgb,255,y,0}
      2 ->
        {:rgb,255-y,255,0}
      3 ->
        {:rgb,0,255,y}
      4 ->
        {:rgb,0,255-y,255}
      _ ->
        :xTooLarge
    end
  end
end
