Code.load_file("brot.ex", __DIR__)

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule BrotTest do
  use ExUnit.Case

  # @tag :pending
  test "1 is not a mandelbrot number" do
    assert Brot.mandelbrot({1,0},30) == 3
  end

  # @tag :pending
  test "-1 is a mandelbrot number" do
    assert Brot.mandelbrot({-1,0},30) == 0
  end

  # @tag :pending
  test "0.2 should be a mandelbrot number" do
    assert Brot.mandelbrot({0.2,0},1500) == 0
  end

  # @tag :pending
  # test "" do
  #   assert ==
  # end
end
