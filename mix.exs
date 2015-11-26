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

  defp description do
    """
    Google Translate in your terminal as Mix package.
    """
  end

  defp package do
    [
      files: ["lib/elmit.ex", "mix.exs"],
      maintainers: ["Pawel Urbanek"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/pawurb/elmit" }
    ]
  end
end
