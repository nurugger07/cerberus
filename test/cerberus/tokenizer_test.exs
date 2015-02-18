defmodule Cerberus.TokenizerTest do
  use ExUnit.Case

  import Cerberus.Tokenizer

  @xml ~s{
    <?xml version="1.0"?>
    <!DOCTYPE book SYSTEM "book.dtd">
    <book id="bk101">
      <author>Gambardella, Matthew</author>
      <price>44.95</price>
      <publish_date>2012-12-21</publish_date>
    </book>
  }

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

  test "tokenize XML" do
    assert @tokens == (tokenize @xml)
  end

end
