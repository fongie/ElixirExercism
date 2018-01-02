use Bitwise

defmodule SecretHandshake do
  @codes %{1 => "wink", 2 => "double blink", 4 => "close your eyes", 8 => "jump"}
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do

    f = fn {key, value} ->
      (code &&& 0b1) == key || (code &&& 0b10) == key || (code &&& 0b100) == key || (code &&& 0b1000) == key end

    Enum.filter(@codes, f)
    |> Enum.map(fn {key, value} -> value end)
    |> Enum.to_list()
    |> reverseList(code)
  end

  def reverseList(l, code) do
    if ((code &&& 0b10000) == 16) do
      Enum.reverse(l)
    else
      l
    end
  end
end

