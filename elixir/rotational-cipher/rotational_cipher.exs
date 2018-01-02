defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    s = rem(shift, 26)

    text
    |> to_charlist()
    |> Enum.map(
      &(if ((&1 in 65..90) || (&1 in 97..122)), do: &1 + s, else: &1)
    )
    |> Enum.map(
      &(if ((&1 > 122) || (&1 in 91..(96 + s))), do: &1 - 26, else: &1)
    )
    |> to_string()
  end

end

