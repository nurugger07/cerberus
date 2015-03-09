defmodule Cerberus.ParserTest do
  use ExUnit.Case

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

end
