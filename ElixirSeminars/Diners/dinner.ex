defmodule Dinner do

  def start() do
    spawn(fn -> init() end)
  end

  def init() do
    c1 = Chopstick.start
    c2 = Chopstick.start
    c3 = Chopstick.start
    c4 = Chopstick.start
    c5 = Chopstick.start
    ctrl = self()
    Philosopher.start(5, c1, c2, "Socrates", ctrl)
    Philosopher.start(5, c1, c2, "Plato", ctrl)
    Philosopher.start(5, c1, c2, "Euklides", ctrl)
    Philosopher.start(5, c1, c2, "Aristoteles", ctrl)
    Philosopher.start(5, c1, c2, "Seneca", ctrl)
    wait(5, [c1, c2, c3, c4, c5])
    IO.puts "SUCCESS"
  end

  def wait(0, chopsticks) do
    Enum.each(chopsticks, fn(c) -> Chopstick.terminate(c) end)
  end

  def wait(n, chopsticks) do
    receive do
      :done ->
        wait(n-1, chopsticks)
      :abort ->
        Process.exit(self(), :kill)
    end
  end
end
