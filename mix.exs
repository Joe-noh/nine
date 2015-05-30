defmodule Nine.Mixfile do
  use Mix.Project

  def project do
    [app: :nine,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {Nine, []}]
  end

  defp deps do
    latest = ">= 0.0.0"

    [
      {:ex_doc,  latest, only: :docs},
      {:earmark, latest, only: :docs},
      {:dialyze, latest, only: :dev}
    ]
  end
end
