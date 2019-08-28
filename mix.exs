defmodule Staxx.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  defp releases() do
    [
      staxx: [
        include_executables_for: [:unix],
        applications: [
          runtime_tools: :permanent,
          deployment_scope: :permanent,
          docker: :permanent,
          domains: :permanent,
          event_bus: :permanent,
          proxy: :permanent,
          web_api: :permanent
        ]
      ]
    ]
  end

  defp aliases do
    [
      drop_db: [
        "ecto.drop --quiet"
      ],
      setup_db: [
        "ecto.create --quiet",
        "ecto.migrate",
        "run #{__DIR__}/apps/domains/priv/repo/seeds.exs"
      ],
      test: ["drop_db", "setup_db", "test"]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:telemetry, "~> 0.4"},
      # {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      # {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false},
      {:ex_testchain, github: "makerdao/ex_testchain", branch: "master", runtime: false}
    ]
  end
end
