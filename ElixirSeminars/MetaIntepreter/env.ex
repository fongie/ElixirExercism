defmodule Env do
  @doc """
  Handles the environment (binding of variables to data structures)
  """

  def find_in_env(_, []) do
    :error
  end
  def find_in_env(id, [{id, struct} | _]) do
    {:ok, struct}
  end
  def find_in_env(id, [_ | rest]) do
    find_in_env(id, rest)
  end

  def new() do
    []
  end

  def add(var, struct, env) do
     [{var, struct} | env]
  end

  # Find id in environment, return {id, struct} if found or nil
  def lookup(_, []) do
    nil
  end
  def lookup(id, [{id, struct} | _]) do
    {id, struct}
  end
  def lookup(id, [{_, _} | rest]) do
    lookup(id, rest)
  end

  # Remove all bindings of ids from env and return env without them
  def remove([], env) do
    env
  end
  def remove([id|rest], env) do
    newenv = removeOne(id, env, [])
    remove(rest, newenv)
  end
  def remove(nil, _) do
  end
  def removeOne(id, [{id,_} | rest], newenv) do
    removeOne(id, rest, newenv)
  end
  def removeOne(id, [h|t], newenv) do
    removeOne(id, t, [h | newenv])
  end

  def removeOne(_, [], newenv) do
    newenv
  end

  # Closure returns an environment with only the bindings of the free variables
  def closure(vars, env) do
    closure(vars, env, [])
  end
  def closure([var1 | rest], env, newenv) do
    #[lookup(var1, env) | closure(rest, env)]
    s = lookup(var1, env)
    case s do
      nil ->
        :error
      _ ->
        closure(rest, env, [s | newenv])
    end
  end
  def closure([], _, newenv) do
    newenv
  end

  # Binding arguments via parameters (for function application)
  # args ( parameterlist, structurelist, env )
  def args([],[], env) do
    env
  end
  def args([par1 | parrest], [struct1 | structrest], env) do
    env = [{par1, struct1} | env]
    args(parrest, structrest, env)
  end
end
