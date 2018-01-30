Code.load_file("eager_sequence.ex", __DIR__)
ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule EagerSequenceTest do
  use ExUnit.Case

  #@tag :pending
  test "evaluation simple sequence" do
    assert EagerSequence.eval([{:match, {:var, :x}, {:atm, :a}}, {:var, :x}]) == {:ok,:a}
  end

  # @tag :pending
  test "simple sequence with unbound var at end should fail" do
    assert EagerSequence.eval([{:match, {:var, :x}, {:atm, :a}}, {:var, :y}]) == :error
  end

  # @tag :pending
  test "evaluate sequence with several matchings" do
    assert EagerSequence.eval([{:match, {:var, :y}, {:atm, :b}},
                           {:match, {:var, :x}, {:var, :y}},
                           {:var, :x}]) == {:ok, :b}
  end

  #@tag :pending
  test "eval sample from instructions" do
    assert EagerSequence.eval([{:match, {:var, :x}, {:atm, :a}},
                           {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
                           {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
                           {:var, :z}]) == {:ok, :b}
  end

end
