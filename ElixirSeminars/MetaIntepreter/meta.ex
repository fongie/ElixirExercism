defmodule Meta do
@testSeq  [{:match, {:var, :x}, {:atm,:a}},
{:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
{:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
{:var, :z}]

  def test do
    eval(@testSeq)
  end

  def eval(text) do
    EagerSequence.eval_seq(text, [])
  end
end

IO.puts "Evaluating a sequence: "
IO.inspect Meta.test
