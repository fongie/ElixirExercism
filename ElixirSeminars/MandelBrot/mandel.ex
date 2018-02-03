defmodule Mandel do

  # Creates the mandelbrot function
  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Complex.new(x+k*(w-1), y - k*(h-1))
    end

    rows(width, height, trans, depth, [])
  end


  # Creates "height" number of rows
  def rows(width, height, func, depth, acc) do
    rows(0,0,height,func,depth,[])
  end
  def rows(width, height, maxheight, func, depth, acc) when height <= maxheight do
    newrow = row(0,0,width,func,depth,[])
    rows(width, height+1, maxheight, func, depth, [newrow | acc])
  end
  def rows(width, height, maxheight, func, depth, acc) do
    acc
  end

  # Creates a row of length "maxwidth"
  def row(currentwidth, height, maxwidth, func, depth, acc) when currentwidth <= maxwidth do
    generatedNumber = func.(currentwidth,height)
    depthOfThis = Brot.mandelbrot(generatedNumber, depth)
    color = Colors.convert(depthOfThis, depth)
    row(currentwidth+1, height, maxwidth, func, depth, [color | acc])
  end
  def row(currentwidth, height, maxwidth, func, depth, acc) do
    acc
  end
end
