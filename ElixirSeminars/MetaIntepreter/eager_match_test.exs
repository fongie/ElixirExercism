Code.load_file("eager_match.ex", __DIR__)
ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule EagerMatchTest do
  use ExUnit.Case

  #@tag :pending
  test "matching existing atom" do
    assert EagerMatch.eval_match({:atm, :a}, :a, []) == {:ok, []}
  end

  # @tag :pending
  test "match unbound var to data structure (bind it)" do
    assert EagerMatch.eval_match({:var, :x}, :a, []) == {:ok, [{:x, :a}]}
  end

  # @tag :pending
  test "match on an already existing binding in env is ok (doesnt change env)" do
    assert EagerMatch.eval_match({:var, :x}, :a, [{:x, :a}]) == {:ok, [{:x, :a}]}
  end

  # @tag :pending
  test "match on already bound variable returns fail" do
    assert EagerMatch.eval_match({:var, :x}, :a, [{:x, :b}]) == :fail
  end
  # @tag :pending
  test "double match in structure should fail" do
    assert EagerMatch.eval_match({:cons, {:var, :x}, {:var, :x}}, {:cons, {:atm, :a}, {:atm, :b}},[]) == :fail
  end

  #@tag :pending
  test "match on construct" do
    assert EagerMatch.eval_match({:cons, {:var, :x}, {:var, :y}}, {:cons, {:atm, :a}, {:atm, :b}},[]) == {:ok, [{:y,:b},{:x, :a}]}
  end
  #@tag :pending
  test "match var to construct" do
    assert EagerMatch.eval_match({:var, :y}, {:cons, {:atm, :x}, {:atm, :b}}, []) == {:ok, [{:y, {:x, :b}}]}
  end

  #@tag :pending
  test "match var to closure" do
    assert EagerMatch.eval_match({:var, :f}, {:closure, [:y], [{:cons, {:var, :x}, {:var, :y}}], [{:x, :a}]}, []) == {:ok, [{:f, {:closure, [:y], [{:cons, {:var, :x}, {:var, :y}}], [{:x, :a}]}}]}
  end
end
