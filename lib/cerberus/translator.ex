defmodule Cerberus.Translator do
  import Cerberus.Tokenizer
  import Cerberus.Compiler

  def translate(xml, :json) do
    xml |> tokenize |> compile(:json)
  end
end
