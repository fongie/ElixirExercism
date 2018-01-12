defmodule Bob do
  def hey(input) do
    cond do
      Regex.match?(~r/^\s*$/, input) -> "Fine. Be that way!"  
      Regex.match?(~r/^.*\?$/, input) -> "Sure."  
      String.upcase(input) == input && String.downcase(input) != input -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
