defmodule DmsWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DmsWebWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:dms_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DmsWeb.PubSub},
      # Start a worker by calling: DmsWeb.Worker.start_link(arg)
      # {DmsWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      DmsWebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DmsWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DmsWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
