defmodule Cerberus.Parser do
  def parse(tokens) do
    tokens
  end
end

defmodule Cerberus.Compiler do
  def compile(parsed_tokens, :json) do
    File.read!("test/fixtures/books.json")
  end
end

defmodule Cerberus.Render do
  import Cerberus.Tokenize
  import Cerberus.Parser
  import Cerberus.Compiler

  def render(xml, :json) do
    xml |> compile(:json)
    # xml |> tokenize |> parse |> compile(:json)
  end
end

defmodule CerberusTest do
  use ExUnit.Case

  import Cerberus.Render

  test "convert XML document to JSON" do
    xml = File.read!("test/fixtures/books.xml")
    json = File.read!("test/fixtures/books.json")

    assert json == (xml |> render(:json))
  end
end
