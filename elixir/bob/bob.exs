defmodule Bob do
  def hey(input) do
    cond do
      Regex.match?(~r/^\s*$/, input) -> "Fine. Be that way!"  
      Regex.match?(~r/^[^a-z]+[^?]$/, input) -> "Whoa, chill out!"
      Regex.match?(~r/^.*\?$/, input) -> "Sure."  
      true -> "Whatever."
    end
  end
end
