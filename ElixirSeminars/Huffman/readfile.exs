import Huffman

file = read("kallocain.txt",10000)
       |> to_string

tree = tree(file)
encode = encode_table(tree)
decode = decode_table(tree)
text = file
seq = encode(text, encode)
IO.puts decode(seq, decode)
