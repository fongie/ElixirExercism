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

  # def waiting(name, leftstick, rightstick) do
  #   IO.puts "#{name} is requesting left chopstick"
  #   case Chopstick.request(leftstick, 1000) do
  #     :no ->
  #       # IO.puts "#{name} did not get his left stick... but will try again!"
  #       waiting(name, leftstick, rightstick)
  #     :ok ->
  #       IO.puts "#{name} is requesting right chopstick"
  #       case Chopstick.request(rightstick, 1000) do
  #         :no ->
  #           # IO.puts "#{name} is returning left chopstick because right one was taken, and trying again!"
  #           Chopstick.return(leftstick)
  #           waiting(name, leftstick, rightstick)
  #         :ok ->
  #           true
  #       end
  #   end
  # end
  #

  def waiting(name, leftstick, rightstick) do
    IO.puts "#{name} is requesting both sticks!"
    Chopstick.request(leftstick, 1000, self())
    Chopstick.request(rightstick, 1000, self())

    receive do
      :no ->
        waiting(name, leftstick, rightstick)
      {:ok, from} ->
        onegranted(from, name, leftstick, rightstick)
    end
  end

  def onegranted(grantedstick, name, leftstick, rightstick) do
    receive do
      :no ->
        Chopstick.return(grantedstick)
        waiting(name, leftstick, rightstick)
      {:ok, from} ->
        true
    end
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
