Code.load_file("mandel.ex", __DIR__)

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule MandelTest do
  use ExUnit.Case

  test "rows" do
    assert Mandel.mandelbrot(128,128,-2.6,1.2,(1.2+2.6)/128,64) == "a"
  end

end
