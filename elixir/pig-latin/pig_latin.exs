defmodule PigLatin do
  @vowels ["a","e","i","o","u","yt", "xr"]
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&(translateWord(&1)))
    |> Enum.join(" ")
  end

  defp translateWord(word) do
    if String.starts_with?(word, @vowels) do 
      word <> "ay"
    else 
      { beg, rest } = splitWord(word)
      rest <> beg <> "ay"
    end
  end

  defp splitWord(word) do
    { beg, rest } = { String.slice(word, 0..findLastConsonant(word)), String.slice(word, (findLastConsonant(word)+1)..-1) }
  end

  defp findLastConsonant(word) do
    word
    |> String.codepoints
    |> Enum.find_index(fn(c) -> c in @vowels end)
    |> Kernel.-(1)
    |> checkForClusters(word)
  end

  defp checkForClusters(lastConsonant, word) do
    if String.at(word, lastConsonant) == "q" and String.at(word, lastConsonant+1) == "u" 
    do lastConsonant + 1 
    else lastConsonant 
    end
  end
end
