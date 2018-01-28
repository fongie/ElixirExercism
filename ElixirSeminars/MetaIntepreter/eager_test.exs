Code.load_file("eager.ex", __DIR__)
ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule EagerTest do
  use ExUnit.Case

  #@tag :pending
  test "evaluate in empty env" do
    assert Eager.eval_expr({:atm, :a},[]) == {:ok, :a}
  end

  #@tag :pending
  test "evalute a bound variable" do
    assert Eager.eval_expr({:var, :x}, [{:x, :a}]) == {:ok, :a}
  end

  #@tag :pending
  test "attempt evaluate non-bound variable" do
    assert Eager.eval_expr({:var, :x}, []) == :error
  end

  #@tag :pending
  test "structure with a variable evaluates to what the variable is bound to in env" do
    assert Eager.eval_expr({:cons, {:var, :x}, {:atm, :b}}, [{:x, :a}]) == {:a, :b}
  end

  #@tag :pending
  test "matching existing atom" do
    assert Eager.eval_match({:atm, :a}, :a, []) == []
  end

  # @tag :pending
  test "match unbound var to data structure (bind it)" do
    assert Eager.eval_match({:var, :x}, :a, []) == {:ok, [{:x, :a}]}
  end

  # @tag :pending
  test "match on an already existing binding in env is ok (doesnt change env)" do
    assert Eager.eval_match({:var, :x}, :a, [{:x, :a}]) == {:ok, [{:x, :a}]}
  end

  # @tag :pending
  test "mathcon already bound variable returns fail" do
    assert Eager.eval_match({:var, :x}, :a, [{:x, :b}]) == :fail
  end


  # @tag :pending
  test "double match in structure should fail" do
    assert Eager.eval_match({:cons, {:var, :x}, {:var, :x}}, {:cons, {:atm, :a}, {:atm, :b}},[]) == :fail
  end

  #@tag :pending
  test "match on construct" do
    assert Eager.eval_match({:cons, {:var, :x}, {:var, :y}}, {:cons, {:atm, :a}, {:atm, :b}},[]) == {:ok, [{:y,:b},{:x, :a}]}
  end

  #@tag :pending
  test "evaluation simple sequence" do
    assert Eager.eval([{:match, {:var, :x}, {:atm, :a}}, {:var, :x}]) == {:ok,:a}
  end

  # @tag :pending
  test "simple sequence with unbound var at end should fail" do
    assert Eager.eval([{:match, {:var, :x}, {:atm, :a}}, {:var, :y}]) == :error
  end

  # @tag :pending
  test "evaluate sequence with several matchings" do
    assert Eager.eval([{:match, {:var, :y}, {:atm, :b}},
                           {:match, {:var, :x}, {:var, :y}},
                           {:var, :x}]) == {:ok, :b}
  end

  #@tag :pending
  test "eval sample from instructions" do
    assert Eager.eval([{:match, {:var, :x}, {:atm, :a}},
                           {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
                           {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
                           {:var, :z}]) == {:ok, :b}
  end

  #HUR SKA DENNA FUNKA?
  @tag :pending
  test "match var to construct" do
    assert Eager.eval_match({:var, :y}, {:cons, {:atm, :x}, {:atm, :b}}, []) == {:ok, [{:y, {:x, :b}}]}
  end

  # @tag :pending
  # test "" do
  #   assert Eager.eval_seq() ==
  # end
end
