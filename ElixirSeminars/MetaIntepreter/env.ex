defmodule Env do

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
  def removeOne(id, [{id,_} | rest], newenv) do
    removeOne(id, rest, newenv)
  end
  def removeOne(id, [h|t], newenv) do
    removeOne(id, t, [h | newenv])
  end

  def removeOne(_, [], newenv) do
    newenv
  end

end
