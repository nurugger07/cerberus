defmodule Cerberus.Tokenize do
  @regex ~r/(?:<(\w*)>|<(.*)>|>?(.*?)<)/

  def tokenize(xml) when is_binary(xml) do
    Regex.split(~r{\n}, xml, trim: true) |> tokenize |> List.flatten
  end

  def tokenize([]), do: []
  def tokenize([line|tail]) do
    [ String.strip(line) |> process | tokenize(tail)]
  end

  defp process(line) do
    process_line(line, line)
  end

  defp process_line("<?xml version=" <> _, origin) do
    [{:header, origin }]
  end

  defp process_line("<!DOCTYPE" <> _, origin) do
    [{:doctype, origin }]
  end

  defp process_line(line, origin) do
    Regex.split(~r/[<>]/, line, trim: true) |> tokens(origin)
  end

  defp tokens([element, value, "/" <> _], origin) do
    [{:element, element, value, origin}]
  end

  defp tokens([], _), do: []
  defp tokens([[ _, element]| t], origin) do
    [{:start_node, element, origin}]  ++ tokens(t, origin)
  end

  defp tokens([[ _, _, attribute]| t], origin) do
    attribute = Regex.replace(~r/[\"']/, attribute, "")
    [attribute, value] = Regex.split(~r/=/, attribute, trim: true)
    [{:attribute, attribute, value, origin}] ++ tokens(t, origin)
  end

  defp tokens(["/" <> rest], origin) do
    [{:end_node, rest, origin}]
  end

  defp tokens([element], origin) do
    Regex.scan(~r/(?:([-:\w]+)|\s*([-:\w]+\s*=\s*(?:(?:'.*?')|(?:".*?"))\s*))/, element) |> tokens(origin)
  end

end
