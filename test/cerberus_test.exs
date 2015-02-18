defmodule CerberusTest do
  use ExUnit.Case

  import Cerberus.Translator

  @json Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, File.read!("test/fixtures/books.json"), "")
  @xml File.read!("test/fixtures/books.xml")

  test "convert XML document to JSON" do
    assert @json == (@xml |> translate(:json))
  end

end
