defmodule Chopstick do

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      :ok -> :ok
    end
  end

  def start do
    stick = spawn_link(fn -> available() end)
  end

  def available() do
    receive do
      {:request, from}  ->
        send(from, :ok)
        gone()
      :quit ->
        :ok
    end
  end

  def gone() do
    receive do
      :return ->
        available()
      :quit -> :ok
    end
  end
end
