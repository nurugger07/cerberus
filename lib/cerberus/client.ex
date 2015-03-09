defmodule Cerberus.Connection do
  use HTTPoison.Base

  def http_request(:get, url), do: HTTPoison.get!(url)
end

defmodule Cerberus.Wsdl do

  import Cerberus.Connection

  def operations(file) do
    file |> get_wsdl |> parse_xml |> read_wsdl
  end

  @doc """
    Retrieve the wsdl
  """
  def get_wsdl("http://" <> _ = url), do: http_request(:get, url).body
  def get_wsdl("https://" <> _ = url), do: http_request(:get, url).body
  def get_wsdl("file://" <> file), do: file |> get_wsdl
  def get_wsdl(file), do: File.read!(file)

  @doc """
    Parse xml
  """
  def parse_xml(xml) when is_binary(xml), do: xml |> to_char_list |> parse_xml
  def parse_xml(xml) when is_list(xml), do: xml |> :xmerl_scan.string

  def read_wsdl([]), do: []
  def read_wsdl([head|tail]) do
    read_wsdl tail
  end
  def read_wsdl(thing) do
    thing
  end
end

defmodule Cerberus.Client do

  import Cerberus.Wsdl

  # parse wsdl from file and retreive a list of operations
  # soap call
  # target URL
  # SOAP Action
  # set parameters
  # invoke
  # validate response

  def call(wsdl, soap_action, options) do
    wsdl |> operations
  end

end
