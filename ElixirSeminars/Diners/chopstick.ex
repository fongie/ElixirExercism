defmodule Chopstick do

  @doc """
  Interface to the philosophers
  """

  def request(stick, timeout, philosopher) do
    send(stick, {:request, self()})
    receive do
      :ok -> send(philosopher, {:ok, self()})
    after timeout ->
      send(philosopher, :no)
    end
  end

  # def request(stick, timeout) do
  #   send(stick, {:request, self()})
  #   receive do
  #     :ok -> :ok
  #   after timeout ->
  #     :no
  #   end
  # end

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      :ok -> :ok
    end
  end

  def return(stick) do
    send(stick, :return)
    :ok
  end

  def terminate(stick) do
    Process.exit(stick, :normal)
  end

  def start() do
    stick = spawn_link(fn -> available() end)
  end

  # Internals
  defp available() do
    receive do
      {:request, from}  ->
        send(from, :ok)
        gone()
      :quit ->
        :ok
    end
  end

  defp gone() do
    receive do
      :return ->
        available()
      :quit -> :ok
    end
  end
end
