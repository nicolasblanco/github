defmodule Github.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :github,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/WorkflowCI/github"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:poison, "~> 3.1"},

      {:ex_doc, "~> 0.18.0", only: :dev},

      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp description() do
    "The simplest client for GitHub REST API v3."
  end

  defp package do
    [
      maintainers: ["exAspArk"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/WorkflowCI/github"}
    ]
  end
end
