Code.load_file("env.ex", __DIR__)
ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule EnvTest do
  use ExUnit.Case

  #@tag :pending
  test "empty environment with new" do
    assert Env.new() == []
  end

  #@tag :pending
  test "add to empty environment" do
    assert Env.add(:a, 42, Env.new()) == [{:a, 42}]
  end

  #@tag :pending
  test "add to nonempty environment" do
    assert Env.add(:b, 43, [{:a,42}]) == [{:b, 43}, {:a, 42}]
  end

  #@tag :pending
  test "lookup in empty env" do
    assert Env.lookup(:b, []) == nil
  end

  #@tag :pending
  test "lookup existing var" do
    assert Env.lookup(:a, [{:a,42},{:b,43}]) == {:a,42}
  end

  #@tag :pending
  test "lookup nonexisting var" do
    assert Env.lookup(:c, [{:a,42},{:b,43}]) == nil
  end

  #@tag :pending
  test "remove no ids" do
    assert Env.remove([], [{:a,41}]) == [{:a,41}]
  end
  #@tag :pending
  test "remove nonexisting ids" do
    assert Env.remove([:a], [{:b,41},{:c,40}]) == [{:c,40}, {:b,41}]
  end

  #@tag :pending
  test "remove from empty env" do
    assert Env.remove([:a], []) == []
  end

  #@tag :pending
  test "remove one id" do
    assert Env.remove([:a], [{:a,42},{:b,41}]) == [{:b,41}]
  end

  #@tag :pending
  test "remove many ids" do
    assert Env.remove([:a,:b], [{:a,42},{:b,41},{:c,40}]) == [{:c, 40}]
  end

  #@tag :pending
  test "env test from instructions" do
    assert Env.lookup(:foo, Env.add(:foo, 42, Env.new())) == {:foo, 42}
  end

  #@tag :pending
  test "simple closure" do
    assert Env.closure([:x], [{:x, :a}]) == [{:x, :a}]
  end

  #@tag :pending
  test "closure over bigger env" do
    assert Env.closure([:x, :y], [{:x, :a}, {:y, :b}, {:z, :c}]) == [{:y, :b},{:x, :a}]
  end

  #@tag :pending
  test "closure trying to find unbound vars should return error" do
    assert Env.closure([:x], [{:y, :b}]) == :error
  end

  #@tag :pending
  test "apply argument to closure environment" do
    assert Env.args([:y], [:b], [{:x, :a}]) == [{:y, :b}, {:x, :a}]
  end
  #@tag :pending
  test "apply several arguments to closure environment" do
    assert Env.args([:y, :z], [:b, :c], [{:x, :a}]) == [{:z, :c}, {:y, :b}, {:x, :a}]
  end
end
