Code.load_file("eager_expression.ex", __DIR__)
ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule EagerExpressionTest do
  use ExUnit.Case

    @prgm  [{:append, [:x, :y],
      [{:case, {:var, :x},
      [{:clause, {:atm, []}, [{:var, :y}]},
       {:clause, {:cons, {:var, :hd}, {:var, :tl}},
         [{:cons,
           {:var, :hd},
           {:call, :append, [{:var, :tl}, {:var, :y}]}}]
       }]
      }]
    }]
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
    assert EagerExpression.eval_expr({:cons, {:var, :x}, {:atm, :b}}, [{:x, :a}]) == {:ok, {:a, :b}}
  end

  #@tag :pending
  test "evaluate case expression" do
    assert EagerExpression.eval_expr({:case, {:atm, :a}, [{:clause, {:atm, :b}, [:atm, :no]}, {:clause, {:atm, :a}, [{:atm, :yes}]}]}, []) == {:ok, :yes}
  end

  #@tag :pending
  test "evaluate instructions sample case clause" do
    assert EagerSequence.eval([{:match, {:var, :x}, {:atm, :a}}, {:case, {:var, :x}, [{:clause, {:atm, :b}, [{:atm, :ops}]}, {:clause, {:atm, :a}, [{:atm, :yes}]} ]} ]) == {:ok, :yes}
  end

  #@tag :pending
  test "eval simple closure" do
    assert EagerExpression.eval_expr({:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}, [{:x, :a}]) == {:ok, {:closure, [:y], [{:cons, {:var, :x}, {:var, :y}}], [{:x, :a}]}}
  end

  #@tag :pending
  test "lambda function example from instructions" do
    assert EagerSequence.eval([{:match, {:var, :x}, {:atm, :a}}, {:match, {:var, :f}, {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}}, {:apply, {:var, :f}, [{:atm, :b}]}]) == {:ok, {:a, :b}}
  end

  #@tag :pending
  test "evaluate list of expressions, return list of structures" do
    assert EagerExpression.eval_expr([{:var, :x}, {:var, :y}], [{:x, :a}, {:y, :b}, {:z, :c}]) == [:a, :b]
  end

  # @tag :pending
  test "evaluate first recursion call in sample program" do
    assert EagerExpression.eval_expr({:call, :append, [{:var, :tl}, {:var, :y}]}, [{:tl, {:b, []}}, {:hd, :a}, {:y, {:c, {:d, []}}}, {:x, {:a, {:b, []}}}], @prgm) == {:ok, {:b, {:c, {:d, []}}}}
  end

  #@tag :pending
  test "named function example from instructions" do

    seq = [{:match, {:var, :x},
      {:cons, {:atm, :a}, {:cons, {:atm, :b}, {:atm, []}}}},
           {:match, {:var, :y},
             {:cons, {:atm, :c}, {:cons, {:atm, :d}, {:atm, []}}}},
           {:call, :append, [{:var, :x}, {:var, :y}]}
    ]
            assert EagerSequence.eval_seq(seq, [], @prgm) == {:ok, {:a, {:b, {:c, {:d, []}}}}}
  end
end
