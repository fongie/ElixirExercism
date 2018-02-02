ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule ComplexTest do
  use ExUnit.Case

  # @tag :pending
  test "new complex number, represented as tuple" do
    assert Complex.new(1, 1) == {1, 1}
  end

  # @tag :pending
  test "adding complex numbers" do
    assert Complex.add({2,2},{1,3}) == {3,5}
  end

  # @tag :pending
  test "squaring complex numbers" do
    assert Complex.sqr({2,4}) == {-12, 16}
  end

  # @tag :pending
  test "absolute value of complex number" do
    assert Complex.abs({3, 4}) == 5
  end
end
