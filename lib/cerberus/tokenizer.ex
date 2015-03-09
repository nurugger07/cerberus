defmodule Cerberus.Tokenizer do

  def tokenize(xml) when is_binary(xml), do: xml |> to_char_list |> tokenize

  def tokenize(xml) when is_list(xml) do
    {tokens, _} = xml |> :xmerl_scan.string
    tokens
  end

end
