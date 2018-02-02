defmodule Complex do
  @doc """
  Handles calculations with complex numbers, represented as {a,b} where a is real and b is imaginary
  """

  def new(real, imaginary) do
    {real, imaginary}
  end

  def add({a1,b1},{a2,b2}) do
    {a1+a2, b1+b2}
  end
  def add(_,_) do
    :error
  end

  def sqr({r, im}) do
    {r*r-im*im, 2*r*im}
  end

  def sqr(_) do
    :error
  end

  def abs({r, im}) do
    :math.sqrt(r*r + im*im)
  end

  def abs(_) do
    :error
  end
end
