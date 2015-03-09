defmodule Cerberus.ClientTest do
  use ExUnit.Case

  import Cerberus.Client

  @wsdl "https://raw.githubusercontent.com/healthagentech/savon_proxy_spike/master/wsdl/MemberInquiry/MemberInquiry.wsdl?token=AAVjaQEJaYwAavh5uElSbjwZ0uh4lW4Lks5VBxyzwA%3D%3D"

  setup do
    HTTPoison.start
  end

  test "parse the wsdl file" do
    xml = call(@wsdl, :getMemberByIdWithName, {})
    assert xml
  end
end
