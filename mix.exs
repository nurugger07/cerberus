defmodule Cerberus.Mixfile do
  use Mix.Project

  def project do
    [app: :cerberus,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.6.2"}]
  end
end
