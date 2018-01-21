defmodule Huffman do

  def sample do
    "the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off"
  end
  def text do 
    "this is something that we should encode"
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def tree(sample) do
    # To implement...
    sample
    |> freq
    |> create_min_prio_queue
    #|> build_tree
  end

  # Takes a min priority queue and turns it into a Huffman tree, using the huffman greedy algorithm
  def build_tree(min_prio_queue) when length(min_prio_queue) > 1 do
    [{char1, freq1} | t1] = min_prio_queue 
    [{char2, freq2} | t2] = t1
    newNode = {{char1,char2}, freq1+freq2}
    # Maybe I have to sort first?? The created node might not (probably isnt) lower frequency than the highest occuring character!!
    build_tree(t2 ++ [newNode])
  end

  #TODO IM WORKING ON THIS FUNCTION, CHECK WIKIPEDIA FOR THE ACTUAL ALGORITHM

  def build_tree(min_prio_queue) do
    min_prio_queue
  end

  # Takes a list of tuples [{"c", i},...] where c is a single character and i the frequency, and orders this so the HEAD is the least occuring character.
  def create_min_prio_queue(frequency_list) do
    frequency_list
    |> Enum.sort(fn ({_, i1}, {_,i2}) -> i1 <= i2 end)
  end

  def encode_table(tree) do
    # To implement...
  end

  def decode_table(tree) do
    # To implement...
  end

  def encode(text, table) do
    # To implement...
  end

  def decode(seq, tree) do
    # To implement...
  end

  def freq(sample) do
    sample 
    |> String.codepoints
    |> freq(%{})
  end
  def freq([], acc) do
    acc
    |> Map.to_list
  end
  def freq([char | rest], acc) do
    acc = acc
          |> Map.update(char, 1, &(&1 +1)) #updates map, checks for key, if key not preset inserts 1, if present updates the value by incrementing it by 1
    freq(rest, acc)
  end
end
