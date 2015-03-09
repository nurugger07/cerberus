defmodule Cerberus.Translator do
  import Cerberus.Tokenizer
  import Cerberus.Compiler

  def translate(xml) do
    xml |> tokenize |> compile
  end
end
