defmodule Elmit.Mixfile do
  use Mix.Project

  def project do
    [app: :elmit,
     version: "0.0.1",
     elixir: "~> 1.1.0",
     escript: [main_module: Elmit],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:httpotion]]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"}
    ]
  end
end
