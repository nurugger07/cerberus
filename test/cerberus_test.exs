defmodule CerberusTest do
  use ExUnit.Case

  import Cerberus.Translator

  @json Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, File.read!("test/fixtures/books.json"), "")
  @xml File.read!("test/fixtures/books.xml")

  @simple_json Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, File.read!("test/fixtures/simple_soap.json"), "")
  @simple_soap File.read!("test/fixtures/simple_soap.xml")

  @complex_json Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, File.read!("test/fixtures/complex_soap.json"), "")
  @complex_soap File.read!("test/fixtures/complex_soap.xml")

  # test "convert XML document to JSON" do
  #   assert @json == (@xml |> translate)
  # end

  # test "convert simple SOAP to JSON" do
  #   assert @simple_json == (@simple_soap |> translate)
  # end

  # test "convert complex SOAP to JSON" do
  #   assert @complex_json == (@complex_soap |> translate)
  # end

end
