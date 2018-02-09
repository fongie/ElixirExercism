defmodule Chopstick do

  def start do
    stick = spawn_link(fn -> available() end)
  end

  def available() do
    receive do
      {:request, from}  ->
        IO.puts "GOING TO GONE MSG FROM"
        IO.inspect from
        gone()
      :quit ->
        :ok
    end
  end

  def gone() do
    raise "fault"
    receive do
      :return ->
        IO.puts "GOING BACK TO AVAILABLE"
        available()
      :quit -> :ok
    end
  end
end
