defmodule Meta do
@testSeq  [{:match, {:var, :x}, {:atm,:a}},
{:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
{:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
{:var, :z}]

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
          def test do
            eval(@testSeq)
          end

  def prog do
    eval(@prgm)
  end

  def eval(text) do
    EagerSequence.eval_seq(text, [])
  end
end

IO.puts "Evaluating a sequence: "
IO.inspect Meta.test

IO.puts "Evaluating a program: "
IO.inspect Meta.prog
