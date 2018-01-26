import Huffman

file = read("kallocain.txt",100000)
       |> to_string
encode = encode_table(tree)
decode = decode_table(tree)
text = file
seq = encode(text, encode)
IO.puts decode(seq, decode)
