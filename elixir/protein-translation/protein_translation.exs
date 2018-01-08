defmodule ProteinTranslation do

  @chart %{
  "UGU" => "Cysteine",
  "UGC" => "Cysteine",
  "UUA" => "Leucine",
  "UUG" => "Leucine",
  "AUG" => "Methionine",
  "UUU" => "Phenylalanine",
  "UUC" => "Phenylalanine",
  "UCU" => "Serine",
  "UCC" => "Serine",
  "UCA" => "Serine",
  "UCG" => "Serine",
  "UGG" => "Tryptophan",
  "UAU" => "Tyrosine",
  "UAC" => "Tyrosine",
  "UAA" => "STOP",
  "UAG" => "STOP",
  "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    check_codons(rna, [])
  end

  defp check_codons(strand, acc) when strand != "" do
    { head, tail } = String.split_at(strand, 3)

    case h = @chart[head] do
      nil -> rna_error()
      "STOP" -> check_codons("", acc)
      _-> check_codons(
      tail, 
      acc ++ [ h ]
    )
    end
  end

  defp check_codons("", acc) do
    { :ok, acc }
  end

  defp rna_error do
    { :error, "invalid RNA" }
  end


  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    if @chart[codon] == nil do codon_error() else { :ok, @chart[codon] } end
  end

  defp codon_error() do
    { :error, "invalid codon" }
  end
end
