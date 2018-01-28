defmodule Eager do
  # atoms are represented as {:atm, a} (this is the atom named a), and variables
  # as {:var, b} (this is the variable named b)
  # this termin {:a, {x, :b}} would then translate to:
  # {{:atm, a}, {{:var, x}, {:atm, b}}}
  #

  # Sequence evaluation

  def eval(sequence) do
    eval_seq(sequence, [])
  end

  def eval_seq([expression], env) do
    eval_expr(expression, env)
  end

  def eval_seq([{:match, pattern, exp}| rest], env) do
    # IO.inspect env
    # IO.inspect eval_expr(exp, env)
    case eval_expr(exp, env) do
      {:ok, struct} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        # IO.inspect eval_match(pattern, struct, env)
        case eval_match(pattern, struct, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env)
        end
      {struct1, struct2} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        # IO.inspect eval_match(pattern, {struct1, struct2}, env)
        # TODO: FUNCTION IS FAILING HERE ON y = {x,:b} IN SEQUENCE, ARE MY FUNCS EQUIPPED TO HANDLE {x,y} DATA STRUCTURES?
        case eval_match(pattern, {struct1, struct2}, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env)
        end
    end
  end

  def extract_vars({:var, id}) do
    [id]
  end
  def extract_vars(_) do
  end

  # Pattern matching
  def eval_match({:atm, id}, id, env) do
    env
  end
  def eval_match({:var, id}, struct, env) do
    case find_in_env(id, env) do
      {:ok, ^struct} -> #binding was already present (same id and struct)
        {:ok, env}
      {:ok, _} -> #id was bound but not to the same struct, should fail
        :fail
      :error -> #id wasnt present (then we create the new binding)
        {:ok, [{id, struct} | env]}
    end
  end
  def eval_match({:cons, p1, p2}, {:cons, {_, struct1}, {_, struct2}}, env) do
    case eval_match(p1, struct1, env) do
      :fail ->
        :fail #var already bound in env
      {:ok, env} -> #var not bound, extended env was returned - now check nr 2
        eval_match(p2, struct2, env) #this is returned at end, shows fail if already bound, proper extended env if not
    end
  end
  def eval_match(_,_,_) do #nothing matched, return fail
    :fail
  end

  # Evaluating expressions
  def eval_expr({:atm, id}, _) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    find_in_env(id,env)
  end

  def eval_expr({:cons, expr1, expr2}, env) do
    case eval_expr(expr1, env) do
      :error ->
        :error
      {:ok, id1} ->
        case eval_expr(expr2, env) do
          :error ->
            :error
          {:ok, id2} ->
            {id1, id2}
        end
    end
  end
  def find_in_env(_, []) do
    :error
  end
  def find_in_env(id, [{id, struct} | _]) do
    {:ok, struct}
  end
  def find_in_env(id, [_ | rest]) do
    find_in_env(id, rest)
  end

end
