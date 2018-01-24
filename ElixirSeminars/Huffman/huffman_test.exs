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
    assert Huffman.create_min_prio_queue([{"a",3},{"b",2}]) == [{"b",2},{"a",3}]
  end

  #@tag :pending
  test "prio queue for given sample is correct" do
    assert Huffman.create_min_prio_queue(
      [{"\n", 4}, {" ", 62}, {"a", 13}, {"b", 7}, {"c", 5}, {"d", 4}, {"e", 24}, {"f", 6}, {"g", 2}, {"h", 9}, {"i", 11}, {"j", 1}, {"k", 1}, {"l", 17}, {"m", 3}, {"n", 13}, {"o", 15}, {"p", 6}, {"q", 2}, {"r", 10}, {"s", 13}, {"t", 20}, {"u", 10}, {"v", 1}, {"w", 9}, {"x", 2}, {"y", 5}, {"z", 1}]) 
      == 
        [{"j", 1}, {"k", 1}, {"v", 1}, {"z", 1}, {"g", 2}, {"q", 2}, {"x", 2}, {"m", 3},{"\n", 4}, {"d", 4}, {"c", 5}, {"y", 5}, {"f", 6}, {"p", 6}, {"b", 7}, {"h", 9}, {"w", 9}, {"r", 10}, {"u", 10}, {"i", 11}, {"a", 13}, {"n", 13}, {"s", 13}, {"o", 15}, {"l", 17}, {"t", 20}, {"e", 24}, {" ", 62}]
  end

  #@tag :pending
  test "insert into prio queue in middle" do
    assert Huffman.insert_into_queue({"a",3},[{"a",1},{"b",2},{"f",4},{"c",7}]) == [{"a",1},{"b",2},{"a",3},{"f",4},{"c",7}]
  end

  #@tag :pending
  test "insert into prio queue on same value" do
    assert Huffman.insert_into_queue({"a",2},[{"a",1},{"b",2},{"f",4},{"c",7}]) == [{"a",1},{"a",2},{"b",2},{"f",4},{"c",7}]
  end

  #@tag :pending
  test "insert into empty prio queue" do
    assert Huffman.insert_into_queue({"a",2},[]) == [{"a",2}]
  end

  #@tag :pending
  test "insert highest value in prio queue" do
    assert Huffman.insert_into_queue({"b",10},[{"a",1},{"c",3}]) == [{"a",1},{"c",3},{"b",10}]
  end

  #@tag :pending
  test "building a tree of only two leafs" do
    assert Huffman.build_tree([{"a",2},{"b",4}]) == [{{{"a",2},{"b",4}},6}]
  end

  #@tag :pending
  test "building a tree with odd number leafs" do
    assert Huffman.build_tree([{"a",1},{"b",2},{"c",3}]) == [{{{"c", 3}, {{{"a", 1}, {"b", 2}}, 3}}, 6}]
  end

  #@tag :pending
  test "building a tree with four leafs" do
    assert Huffman.build_tree([{"z",1},{"b",2},{"c",3},{"d",4}]) == [{{{"d", 4}, {{{"c", 3}, {{{"z", 1}, {"b", 2}}, 3}}, 6}}, 10}]
  end

  #@tag :pending
  test "building a tree with four leafs and one leaf super big" do
    assert Huffman.build_tree([{"a",1},{"c",3},{"d",4},{"b",102}]) == [{{{"b", 102}, {{{"d", 4}, {{{"a", 1}, {"c", 3}}, 4}}, 8}}, 110}]
  end

  #@tag :pending
  test "tree from simple sample" do
    assert Huffman.tree("aabbbc") == [{{{"b",3},{{{"c",1},{"a",2}},3}},6}]
  end

  #@tag :pending
  test "tree from given sample" do
    assert Huffman.tree(Huffman.sample()) == [{{{{{{{{{"a", 13}, {"n", 13}}, 26}, {{{"s", 13}, {"o", 15}}, 28}}, 54}, {" ", 62}}, 116}, {{{{{{{{{{{"\n", 4}, {"d", 4}}, 8}, {{{{{"g", 2}, {"q", 2}}, 4}, {{{{{"j", 1}, {"k", 1}}, 2}, {{{"v", 1}, {"z", 1}}, 2}}, 4}}, 8}}, 16}, {"l", 17}}, 33}, {{{{{"h", 9}, {"w", 9}}, 18}, {{{{{{{"x", 2}, {"m", 3}}, 5}, {"c", 5}}, 10}, {"r", 10}}, 20}}, 38}}, 71}, {{{{{"t", 20}, {{{"u", 10}, {{{"y", 5}, {"f", 6}}, 11}}, 21}}, 41}, {{{{{"i", 11}, {{{"p", 6}, {"b", 7}}, 13}}, 24}, {"e", 24}}, 48}}, 89}}, 160}}, 276}]
  end
end

