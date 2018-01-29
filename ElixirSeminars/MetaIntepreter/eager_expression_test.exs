Code.load_file("eager_expression.ex", __DIR__)
ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule EagerExpressionTest do
  use ExUnit.Case
  #@tag :pending
  test "evaluate in empty env" do
    assert EagerExpression.eval_expr({:atm, :a},[]) == {:ok, :a}
  end

  #@tag :pending
  test "evalute a bound variable" do
    assert EagerExpression.eval_expr({:var, :x}, [{:x, :a}]) == {:ok, :a}
  end

  #@tag :pending
  test "attempt evaluate non-bound variable" do
    assert EagerExpression.eval_expr({:var, :x}, []) == :error
  end

  #@tag :pending
  test "structure with a variable evaluates to what the variable is bound to in env" do
    assert EagerExpression.eval_expr({:cons, {:var, :x}, {:atm, :b}}, [{:x, :a}]) == {:a, :b}
  end
end
