defmodule Repro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ReproWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:repro, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Repro.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Repro.Finch},
      # Start a worker by calling: Repro.Worker.start_link(arg)
      # {Repro.Worker, arg},
      # Start to serve requests, typically the last entry
      ReproWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Repro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReproWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
