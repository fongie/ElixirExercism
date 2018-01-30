defmodule EagerSequence do
  # atoms are represented as {:atm, a} (this is the atom named a), and variables
  # as {:var, b} (this is the variable named b)
  # this termin {:a, {x, :b}} would then translate to:
  # {{:atm, a}, {{:var, x}, {:atm, b}}}
@testSeq  [{:match, {:var, :x}, {:atm,:a}},
{:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
{:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
{:var, :z}]

  def test do
    eval(@testSeq)
  end

  # Sequence evaluation
  def eval(sequence) do
    eval_seq(sequence, [])
  end

  # Without named functions
  def eval_seq([expression], env) do
    EagerExpression.eval_expr(expression, env)
  end
  def eval_seq([{:match, pattern, exp}| rest], env) do
    case EagerExpression.eval_expr(exp, env) do
      {:ok, struct} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        case EagerMatch.eval_match(pattern, struct, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env)
        end
      {struct1, struct2} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        case EagerMatch.eval_match(pattern, {struct1, struct2}, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env)
        end
    end
  end

  # With named functions
  def eval_seq([expression], env, programs) do
    EagerExpression.eval_expr(expression, env, programs)
  end
  def eval_seq([{:match, pattern, exp}| rest], env, programs) do
    case EagerExpression.eval_expr(exp, env, programs) do
      {:ok, struct} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        case EagerMatch.eval_match(pattern, struct, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env, programs)
        end
      {struct1, struct2} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        case EagerMatch.eval_match(pattern, {struct1, struct2}, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env, programs)
        end
    end
  end

  # Extract vars from pattern (to later remove from env, making rebinding possible)
  def extract_vars({:var, id}) do
    [id]
  end
  def extract_vars({:cons, {:var, v1}, {:var, v2}}) do
    [v1, v2]
  end
  def extract_vars({:cons, _, {:var, v1}}) do
    [v1]
  end
  def extract_vars({:cons, {:var, v1}, _}) do
    [v1]
  end
  def extract_vars(_) do
    []
  end
end
