defmodule Brot do
  @doc """
  Makes the mandelbrot calculations. We set our bound (for which Z is not allowed to go larger than) at 2
  """
  def mandelbrot(complex, iterations) do
    z0 = Complex.new(0,0)
    i = 0
    test(i, z0, complex, iterations)
  end

  def test(iteration, currentZ, complex, maxiterations) do
    cond do
      iteration >= maxiterations ->
        0
      Complex.abs(currentZ) > 2 ->
        iteration
      true ->
        test(iteration+1, Complex.add(Complex.sqr(currentZ), complex), complex, maxiterations)
    end
  end
end
