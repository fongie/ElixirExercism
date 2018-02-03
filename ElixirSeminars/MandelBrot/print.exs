defmodule Print do

  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def small(x0,y0,xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn-x0) / width
    image = Mandel.mandelbrot(width,height,x0,y0,k,depth)
    PPM.write("small.ppm", image)
  end

  #test only printout to io out
  def test() do
    x0 = -2.6
    y0 = 1.2
    xn = 1.2
    width = 960
    height = 540
    depth = 64
    k = (xn-x0) / width
    image = Mandel.mandelbrot(width,height,x0,y0,k,depth)
  end
end

Print.demo()
