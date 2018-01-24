defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    aslist = sentence
    |> String.downcase()
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(fn x -> String.replace(x, ~r/[^A-Z|a-z|åäö|0-9|-]/, "") end)
    |> Enum.filter(fn(x) -> Regex.match?(~r/^[A-z|0-9|åäö|-]+$/, x) end)

    Map.new(aslist, fn x -> {x, count_word_occurence(x, aslist)} end)
  end

  defp count_word_occurence(word, list) do
    list
    |> Enum.reduce(0, fn (x, acc) -> if x === word do acc+1 else acc end end)
  end
end
