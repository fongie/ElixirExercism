defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    s = string
    |> String.to_charlist
    |> Enum.filter(fn x -> isletter(x) end)

    [firstletter | rest] = s

    findacro(rest, [firstletter])
    |> reverse([])
    |> List.to_string
  end

  def findacro([h|t], acc) do
    case h do
      32 ->
        [letter | rest] = t
        findacro(rest, [capitalize(letter) | acc])
      x when x in 33..96 ->
        findacro(t, [h | acc])
      _ ->
        findacro(t, acc)
    end
  end
  def findacro([], acc) do
    acc
  end

  def isletter(x) do
    cond do
      x == 32 ->
        true
      x in 65..90 ->
        true
      x in 97..122 ->
        true
      true ->
        false
    end
  end

  def capitalize(letter) do
    cond do
      letter > 96 ->
        letter-32
      true ->
        letter
    end
  end

  def reverse([h|t], acc) do
    reverse(t, [h | acc])
  end
  def reverse([], acc) do
    acc
  end
end
