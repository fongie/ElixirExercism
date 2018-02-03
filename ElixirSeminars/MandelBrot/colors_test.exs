Code.load_file("colors.ex", __DIR__)

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule ColorsTest do
  use ExUnit.Case

  test "depth on 1.2" do
    assert Colors.convert(1.2,2) == {154,255,0}
  end
end
