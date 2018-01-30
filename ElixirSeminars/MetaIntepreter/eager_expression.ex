defmodule EagerExpression do
  @doc """
  Handles evaluating expressions to data structures
  """

  # Without named functions
  def eval_expr({:atm, id}, _) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    Env.find_in_env(id,env)
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
            {:ok, {id1, id2}}
        end
    end
  end

  def eval_expr({:case, expr, clauses}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, id} ->
        eval_clause(clauses, id, env)
      {id1, id2} ->
        eval_clause(clauses, {id1, id2}, env)
    end
  end

  def eval_expr({:lambda, parameters, freevars, sequence}, env) do
    case Env.closure(freevars, env) do
      :error ->
        :error
      closure_environment ->
        {:ok, {:closure, parameters, sequence, closure_environment}}
    end
  end

  def eval_expr({:apply, expr, args}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, {:closure, par, seq, closureenv}} ->
        case eval_expr(args, env) do
          :error ->
            :error
          structure ->
            env = Env.args(par, structure, closureenv)
            EagerSequence.eval_seq(seq, env)
        end
    end
  end

  #Evaluate many expressions at once, return list of structures
  def eval_expr([exp | rest], env) do
    case eval_expr(exp, env) do
      :error ->
        :error
      {:ok, struct} ->
        [struct | eval_expr(rest, env)]
    end
  end

  def eval_expr([], _) do
    []
  end

  # With named functions
  def eval_expr({:call, id, args}, env, programs) when is_atom(id) do
    case List.keyfind(programs, id, 0) do
      nil ->
        :error
      {_, parameters, sequence} ->
        case eval_expr(args, env) do
          :error ->
            :error
          structure ->
            env = Env.args(parameters, structure, env)
            EagerSequence.eval_seq(sequence, env, programs)
        end
    end
  end

  # Case clauses
  def eval_clause([{:clause, pattern, sequence} | rest], structure, env) do

    case EagerMatch.eval_match(pattern, structure, env) do
      :fail ->
        eval_clause(rest, structure, env)
      {:ok, env} ->
        EagerSequence.eval_seq(sequence, env)
    end
  end
  def eval_clause([], _, _) do
    :error
  end
end
