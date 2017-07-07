defmodule Minerva.Mixfile do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :minerva,
      version: @version,
      description: "Elixir framework for easily writing koans.",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      name: "Minerva",
      docs: docs(),
      source_url: github(),
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "LICENSE"
      ],
      links: %{"github" => github()},
      maintainers: ["Unai Esteibar <uesteibar@gmail.com>"],
      licenses: ["MIT"],
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "Minerva",
      extras: ["README.md"],
    ]
  end

  defp github do
    "https://github.com/uesteibar/minerva"
  end

  def application do
    [
      extra_applications: [:logger, :exfswatch],
      mod: {Minerva.Application, []},
    ]
  end

  defp deps do
    [
      { :exfswatch, "~> 0.4.2" },
      {:credo, "~> 0.3", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.15.1", only: :dev, runtime: false},
    ]
  end
end
