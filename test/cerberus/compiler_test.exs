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

  @soap_tokens [
    {:header, "<?xml version=\"1.0\"?>"},
    {:soap, "<soap:Envelope xmlns:soap=\"http://www.w3.org/2001/12/soap-envelope\" soap:encodingStyle=\"http://www.w3.org/2001/12/soap-encoding\">"},
    {:soap, "<soap:Body xmlns:m=\"http://www.example.org/stock\">"},
    {:start_node, "GetStockPriceResponse", "<m:GetStockPriceResponse>"},
    {:element, "Price", "34.5", "<m:Price>34.5</m:Price>" },
    {:end_node, "GetStockPriceResponse", "</m:GetStockPriceResponse>"},
    {:soap, "</soap:Body>"},
    {:soap, "</soap:Envelope>"}
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

  @soap_json Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, ~s{
    \{
      "GetStockPriceResponse": \{
        "Price": 34.5
      \}
    \}
  }, "")

  # test "compile tokens to JSON" do
  #   assert @json == (compile @tokens)
  # end

  # test "compile SOAP tokens to JSON" do
  #   assert @soap_json == (compile @soap_tokens)
  # end

end
