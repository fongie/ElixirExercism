defmodule TwelveDays do
  @words [
"twelve Drummers Drumming", "eleven Pipers Piping", "ten Lords-a-Leaping", "nine Ladies Dancing", "eight Maids-a-Milking", "seven Swans-a-Swimming", "six Geese-a-Laying", "five Gold Rings", "four Calling Birds", "three French Hens", "two Turtle Doves", "a Partridge"]
  @nums [
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth"
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    wordlist = @words
    |> Enum.reverse()
    |> Enum.drop(number-12)
    |> Enum.reverse()
    |> lastWord()
    |> Enum.join(", ")

    "On the " <> Enum.at(@nums, number-1) <> " day of Christmas my true love gave to me, " <> wordlist <> " in a Pear Tree."
  end

  @doc """
  Inserts "and " to the last word in the list, when there are more than 1 word in the list
  """
  defp lastWord(wordlist) do
    l = length(wordlist)
    if l > 1 do List.replace_at(wordlist, l-1, "and " <> Enum.at(wordlist, l-1))  else wordlist end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    verses(starting_verse, ending_verse, "")
  end

  defp verses(starting_verse, ending_verse, acc) when starting_verse <= ending_verse do
    acc = acc <> verse(starting_verse) <> "\n"
    verses(starting_verse+1, ending_verse, acc)
  end

  defp verses(starting_verse, ending_verse, acc) do
    acc
    |> String.trim()
  end


  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end
end

