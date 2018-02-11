defmodule Philosopher do

  def start(hunger, left, right, name, ctrl) do
    spawn_link(fn -> init(hunger, left, right, name, ctrl) end)
  end

  def init(hunger, left, right, name, ctrl) do
    IO.puts "Initiating philosopher #{name}!"
    dream(name)
    waiting(name, left, right)
    eat(name, hunger, left, right)
    IO.puts "#{name} finished eating!"
    send(ctrl, :done)
  end

  def dream(name) do
    IO.puts "#{name} is dreaming"
    sleep(1000)
  end

  def waiting(name, leftstick, rightstick) do
    IO.puts "#{name} is requesting left chopstick"
    case Chopstick.request(leftstick) do
      :no -> 
        waiting(name, leftstick, rightstick)
      :ok ->
        # TODO IM HERE, GO ON TO RIGHT STICK
        

    end

    IO.puts "#{name} is requesting right chopstick"
    Chopstick.request(rightstick)
  end

  def eat(name, hunger, left, right) do
    IO.puts "#{name} is eating!"
    sleep(hunger * 1000)
    IO.puts "#{name} is returning left chopstick"
    Chopstick.return(left)
    IO.puts "#{name} is returning right chopstick"
    Chopstick.return(right)
  end

  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end
