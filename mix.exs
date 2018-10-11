defmodule ExPartisan.MixProject do
  use Mix.Project

  def project do
    [
      app: :expartisan,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "ExPartisan",
      source_url: "https://github.com/jlerche/expartisan"
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
      {:partisan, git: "https://github.com/lasp-lang/partisan.git", branch: "rename-backend"},
      {:ex_doc, "~> 0.13", only: :dev}
    ]
  end

  defp description do
    """
    ExPartisan is a wrapper around Partisan, an Erlang library part of the Lasp project. Partisan is a flexible, TCP-based membership system.
    """
  end

  defp package do
    [
      name: "expartisan",
      links: %{
        "GitHub" => "https://github.com/jlerche/expartisan"
      }
    ]
  end
end
