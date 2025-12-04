defmodule DmsCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :dms_core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dms_identity, in_umbrella: true},
      {:dms_repo, in_umbrella: true}
    ]
  end
end
