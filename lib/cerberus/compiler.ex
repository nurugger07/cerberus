defmodule Cerberus.Compiler do

  def compile([], _), do: ""
  def compile([token| tail], :json)  do
    compile_json(token, tail) <> seperators(token, tail) <> compile(tail, :json)
  end

  def compile_json({:header, _}, _), do: "{"
  def compile_json({:start_node, node_name, _}, [{:start_node, _, _}|_]), do: "\"#{node_name}\": [{"
  def compile_json({:start_node, node_name, _}, _), do: "\"#{node_name}\": {"
  def compile_json({:end_node, _, _}, [{:end_node, _, _}|_]), do: "}]"
  def compile_json({:end_node, _, _}, [{:start_node, _, _}|_]), do: "},{"
  def compile_json({:end_node, node_name, _}, []), do: "}"
  def compile_json({:attribute, attribute, value, _}, _) do
    compile_json_attributes(attribute, value)
  end
  def compile_json({:element, element, value, _}, _) do
    compile_json_attributes(element, value)
  end
  def compile_json(_, _), do: ""

  def compile_json_attributes(attribute, value) do
    Integer.parse(value) |> handle_numeric_values(attribute, value)
  end

  def handle_numeric_values({ n, ""}, attribute, _), do: "\"#{attribute}\": #{n}"
  def handle_numeric_values({ _, "." <> _}, attribute, value) do
    { f, _ } = Float.parse(value)
    "\"#{attribute}\": #{f}"
  end
  def handle_numeric_values(_, attribute, value), do: "\"#{attribute}\": \"" <> value <> "\""

  def seperators(_, []), do: ""
  def seperators({:header, _}, _), do: ""
  def seperators({:start_node, _, _}, _), do: ""
  def seperators({:element, _, _, _}, [{:end_node, _, _}|_]), do: "}"
  def seperators(_, [{:attribute, _, _, _}| _]), do: ","
  def seperators(_, [{:element, _, _, _}| _]), do: ","
  def seperators(_, _), do: ""

end
