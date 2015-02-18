defmodule Cerberus.Compiler do

  def compile([], _), do: "}"
  def compile([token| tail], :json)  do
    compile_json(token) <> apply_comma(token, tail) <> compile(tail, :json)
  end

  def compile_json({:header, _}), do: "{"
  def compile_json({:start_node, node_name, _}), do: "\"#{node_name}\": {"
  def compile_json({:end_node, node_name, _}), do: "}"
  def compile_json({:attribute, attribute, value, _}) do
    compile_json_attributes(attribute, value)
  end
  def compile_json({:element, element, value, _}) do
    compile_json_attributes(element, value)
  end
  def compile_json(_), do: ""

  def compile_json_attributes(attribute, value) do
    Integer.parse(value) |> handle_numeric_values(attribute, value)
  end

  def handle_numeric_values({ n, ""}, attribute, _), do: "\"#{attribute}\": #{n}"
  def handle_numeric_values({ _, "." <> _}, attribute, value) do
    { f, _ } = Float.parse(value)
    "\"#{attribute}\": #{f}"
  end
  def handle_numeric_values(_, attribute, value), do: "\"#{attribute}\": \"" <> value <> "\""

  def apply_comma(_, []), do: ""
  def apply_comma({:header, _}, _), do: ""
  def apply_comma({:start_node, _, _}, _), do: ""
  def apply_comma(_, [{:attribute, _, _, _}| _]), do: ","
  def apply_comma(_, [{:element, _, _, _}| _]), do: ","
  def apply_comma(_, _), do: ""

end
