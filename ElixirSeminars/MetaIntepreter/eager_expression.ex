defmodule EagerExpression do
  @doc """
  Handles evaluating expressions to data structures
  """

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
            {id1, id2}
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
