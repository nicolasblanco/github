defmodule Github.MixProject do
  use Mix.Project

  @version "0.11.0"

  def project do
    [
      app: :github,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs_config(),
      source_url: "https://github.com/WorkflowCI/github",
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:jason, "~> 1.1", optional: true},
      {:joken, "~> 2.0.0-rc3"},
      {:oauth2, "~> 0.9"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:exvcr, "~> 0.10", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    "The simplest Elixir client for GitHub REST API v3."
  end

  defp package do
    [
      maintainers: ["exAspArk"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/WorkflowCI/github"}
    ]
  end

  defp docs_config do
    [
      extras: [
        {"README.md", [title: "Overview"]},
        {"CHANGELOG.md", [title: "Changelog"]}
      ],
      main: "readme"
    ]
  end
end
