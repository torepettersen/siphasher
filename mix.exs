defmodule Siphasher.MixProject do
  use Mix.Project

  @source_url "https://github.com/torepettersen/siphasher"
  @version "0.1.0"

  def project do
    [
      app: :siphasher,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
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
      {:rustler, ">= 0.0.0", optional: true},
      {:rustler_precompiled, "~> 0.6"},
      {:ex_doc, "~> 0.30.2", only: [:dev, :test]}
    ]
  end

  defp description do
    "Elixir Bindings for the SipHash Algorithm"
  end

  defp package do
    [
      files: ~w(
        lib
        native/siphasher/src
        native/siphasher/Cargo.*
        native/siphasher/.cargo
        checksum-*.exs
        mix.exs
        LICENSE
        README.md
      ),
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      maintainers: ["Tore Pettersen"]
    ]
  end
end
