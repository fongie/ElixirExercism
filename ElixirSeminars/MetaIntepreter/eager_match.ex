defmodule EagerMatch do
  @doc """
  Handles pattern matching in our language
  """

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end
  def eval_match({:var, id}, {a1,a2}, env) do #needed this to evaluate sequence when an exp was already evaluated to {:a,:b}, not with {:cons}
    case Env.find_in_env(id, env) do
      {:ok, {^a1,^a2}} ->
        {:ok, env}
      {:ok, _} ->
        :fail
      :error ->
        {:ok, [{id, {a1,a2}} | env]}
    end
  end
  def eval_match({:var, id}, {:cons, {_, struct1}, {_, struct2}}, env) do
    case Env.find_in_env(id, env) do
      {:ok, {^struct1, ^struct2}} ->
        {:ok, env}
      {:ok, _} ->
        :fail
      :error ->
        {:ok, [{id, {struct1, struct2}} | env]}
    end
  end
  def eval_match({:var, id}, struct, env) do
    case Env.find_in_env(id, env) do
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
  def eval_match({:cons, p1, p2}, {s1,s2}, env) do
    case eval_match(p1, s1, env) do
      :fail ->
        :fail
      {:ok, env} ->
        eval_match(p2, s2, env)
    end
  end
  def eval_match(:ignore, _, env) do
    {:ok, env}
  end
  def eval_match(_,_,_) do #nothing matched, return fail
    :fail
  end
end
