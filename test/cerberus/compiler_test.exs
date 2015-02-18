defmodule Cerberus.CompilerTest do
  use ExUnit.Case

  import Cerberus.Compiler

  @tokens [
    {:header, "<?xml version=\"1.0\"?>"},
    {:doctype, "<!DOCTYPE book SYSTEM \"book.dtd\">"},
    {:start_node, "book", "<book id=\"bk101\">"},
    {:attribute, "id", "bk101", "<book id=\"bk101\">"},
    {:element, "author", "Gambardella, Matthew", "<author>Gambardella, Matthew</author>"},
    {:element, "price", "44.95", "<price>44.95</price>" },
    {:element, "publish_date", "2012-12-21", "<publish_date>2012-12-21</publish_date>"},
    {:end_node, "book", "</book>"}
  ]

  @json Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, ~s{
    \{
      "book": \{
        "id": "bk101",
        "author": "Gambardella, Matthew",
        "price": 44.95,
        "publish_date": "2012-12-21"
      \}
    \}
  }, "")

  test "compile tokens to JSON" do
    assert @json == (compile @tokens, :json)
  end

end
