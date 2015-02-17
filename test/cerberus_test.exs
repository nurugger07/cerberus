defmodule Cerberus.Tokenize do
  def tokenize(xml) do
    xml
  end

end

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
    xml |> tokenize |> parse |> compile(:json)
  end
end

defmodule Cerberus.TokenizeTest do
  use ExUnit.Case

  import Cerberus.Tokenize

  @xml Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, ~s{
    <?xml version="1.0"?>
    <book id="bk101">
      <author>Gambardella, Matthew</author>
      <title>XML Developer's Guide</title>
      <genre>Computer</genre>
      <price>44.95</price>
      <publish_date>2000-10-01</publish_date>
      <description>An in-depth look at creating applications with XML.</description>
    </book>
  }

  @tokens [
    [ element: "book", attributes
  ]

  test "tokenize XML" do

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
