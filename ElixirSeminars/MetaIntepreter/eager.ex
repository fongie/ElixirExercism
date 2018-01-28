defmodule Eager do
  # atoms are represented as {:atm, a} (this is the atom named a), and variables
  # as {:var, b} (this is the variable named b)
  # this termin {:a, {x, :b}} would then translate to:
  # {{:atm, a}, {{:var, x}, {:atm, b}}}
  #

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
        :fail
      {:ok, env} ->
        eval_match(p2, struct2, env)
    end
  end

  def eval_match(_,_,_) do
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
