if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("huffman.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule HuffmanTest do
  use ExUnit.Case

  #@tag :pending
  test "frequency of 'a' is 1" do
    assert Huffman.freq("a") == [{ "a", 1 }]
  end

  #@tag :pending
  test "frequency of 'aaa' is 3 times a" do
    assert Huffman.freq("aaa") == [{ "a", 3 }]
  end

  #@tag :pending
  test "frequency for a word with different letters" do
    assert Huffman.freq("word") == [{ "d", 1}, { "o", 1}, { "r", 1}, { "w", 1 } ]  end

  #@tag :pending
  test "frequency for sentence with spaces end linebreaks" do
    assert Huffman.freq("he\nhe he") == [{"\n", 1},{" ", 1}, {"e",3},{"h",3}]
  end

  #@tag :pending
  test "prio queue for list of length 2" do
    assert Huffman.create_min_prio_queue([{:leaf,"a",3},{:leaf,"b",2}]) == [{:leaf,"b",2},{:leaf,"a",3}]
  end

  #@tag :pending
  test "prio queue for given sample is correct" do
    assert Huffman.create_min_prio_queue(
      [{:leaf, "\n", 4}, {:leaf, " ", 62}, {:leaf, "a", 13}, {:leaf, "b", 7}, {:leaf, "c", 5}, {:leaf, "d", 4}, {:leaf, "e", 24}, {:leaf, "f", 6}, {:leaf, "g", 2}, {:leaf, "h", 9}, {:leaf, "i", 11}, {:leaf, "j", 1}, {:leaf, "k", 1}, {:leaf, "l", 17}, {:leaf, "m", 3}, {:leaf, "n", 13}, {:leaf, "o", 15}, {:leaf, "p", 6}, {:leaf, "q", 2}, {:leaf, "r", 10}, {:leaf, "s", 13}, {:leaf, "t", 20}, {:leaf, "u", 10}, {:leaf, "v", 1}, {:leaf, "w", 9}, {:leaf, "x", 2}, {:leaf, "y", 5}, {:leaf, "z", 1}])
      ==
        [{:leaf, "j", 1}, {:leaf, "k", 1}, {:leaf, "v", 1}, {:leaf, "z", 1}, {:leaf, "g", 2}, {:leaf, "q", 2}, {:leaf, "x", 2}, {:leaf, "m", 3},{:leaf, "\n", 4}, {:leaf, "d", 4}, {:leaf, "c", 5}, {:leaf, "y", 5}, {:leaf, "f", 6}, {:leaf, "p", 6}, {:leaf, "b", 7}, {:leaf, "h", 9}, {:leaf, "w", 9}, {:leaf, "r", 10}, {:leaf, "u", 10}, {:leaf, "i", 11}, {:leaf, "a", 13}, {:leaf, "n", 13}, {:leaf, "s", 13}, {:leaf, "o", 15}, {:leaf, "l", 17}, {:leaf, "t", 20}, {:leaf, "e", 24}, {:leaf, " ", 62}]
  end

  #@tag :pending
  test "insert into prio queue in middle" do
    assert Huffman.insert_into_queue({:leaf, "a",3},[{:leaf, "a",1},{:leaf, "b",2},{:leaf, "f",4},{:leaf, "c",7}]) == [{:leaf, "a",1},{:leaf, "b",2},{:leaf, "a",3},{:leaf, "f",4},{:leaf, "c",7}]
  end

  #@tag :pending
  test "insert into prio queue on same value" do
    assert Huffman.insert_into_queue({:leaf, "a",2},[{:leaf, "a",1},{:leaf, "b",2},{:leaf, "f",4},{:leaf, "c",7}]) == [{:leaf, "a",1},{:leaf, "b",2},{:leaf, "a",2},{:leaf, "f",4},{:leaf, "c",7}]
  end

  #@tag :pending
  test "insert into empty prio queue" do
    assert Huffman.insert_into_queue({:leaf, "a",2},[]) == [{:leaf, "a",2}]
  end

  #@tag :pending
  test "insert highest value in prio queue" do
    assert Huffman.insert_into_queue({:leaf, "b",10},[{:leaf, "a",1},{:leaf, "c",3}]) == [{:leaf, "a",1},{:leaf, "c",3},{:leaf, "b",10}]
  end

  #@tag :pending
  test "building a tree of only two leafs" do
    assert Huffman.build_tree([{:leaf,"a",2},{:leaf,"b",4}]) == [{:node,{:leaf,"a",2},{:leaf,"b",4},6}]
  end

  #@tag :pending
  test "building a tree with odd number leafs" do
    assert Huffman.build_tree([{:leaf,"a",1},{:leaf,"b",2},{:leaf,"c",3}]) == [{:node,{:leaf,"c",3},{:node,{:leaf,"a",1},{:leaf,"b",2},3},6}]
  end

  #@tag :pending
  test "building a tree with four leafs" do
    assert Huffman.build_tree([{:leaf,"z",1},{:leaf,"b",2},{:leaf,"c",3},{:leaf,"d",4}]) == [{:node, {:leaf,"d", 4}, {:node,{:leaf,"c", 3}, {:node, {:leaf,"z", 1}, {:leaf,"b", 2}, 3}, 6}, 10}]
  end

  #@tag :pending
  test "building a tree with four leafs and one leaf super big" do
    assert Huffman.build_tree([{:leaf, "a",1},{:leaf, "c",3},{:leaf, "d",4},{:leaf, "b",102}]) == [{:node, {:leaf, "b", 102}, {:node, {:leaf, "d", 4}, {:node, {:leaf, "a", 1}, {:leaf, "c", 3}, 4}, 8}, 110}]
  end

  #@tag :pending
  test "tree from simple sample" do
    assert Huffman.tree("aabbbc") == {:node, {:leaf, "b",3},{:node, {:leaf, "c",1},{:leaf, "a",2},3},6}
  end

  #@tag :pending
  test "encoding simple tree" do
    assert Huffman.encode_table({:node, {:leaf,"d", 4}, {:node,{:leaf,"c", 3}, {:node, {:leaf,"z", 1}, {:leaf,"b", 2}, 3}, 6}, 10}) == [{"d",[0]},{"c",[1,0]},{"z",[1,1,0]},{"b",[1,1,1]}]
  end

  @tag :pending
  test "encoding table for sample tree" do
    assert Huffman.encode_table(Huffman.tree(Huffman.sample())) == :test
  end

  #@tag :pending
  test "encoding 'abbccc'" do
    assert Huffman.encode("abbccc", Huffman.encode_table(Huffman.tree("abbccc"))) == [1,0,1,1,1,1,0,0,0]
  end

  #@tag :pending
  test "decoding 'abbccc'" do
    assert Huffman.decode([1,0,1,1,1,1,0,0,0], Huffman.encode_table(Huffman.tree("abbccc"))) == "abbccc"
  end
end

