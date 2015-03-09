defmodule Cerberus.TokenizerTest do
  use ExUnit.Case

  import Cerberus.Tokenizer

  @xml File.read!("test/fixtures/books.xml")
  @soap File.read!("test/fixtures/simple_soap.xml")
  @memberInquiry File.read!("test/fixtures/member_inquiry.xml")

  test "tokenize simple XML" do
    tokens = to_string(inspect tokenize @xml)
    assert File.read!("test/fixtures/books.exs") == tokens
  end

  test "tokenize simple SOAP" do
    tokens = to_string(inspect tokenize @soap)
    assert File.read!("test/fixtures/simple_soap.exs") == tokens
  end

  test "tokenize memberInquiry SOAP response" do
    tokens = to_string(inspect tokenize @memberInquiry)
    assert File.read!("test/fixtures/member_inquiry.exs") == tokens
  end
end
