defmodule TuneUp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TuneUpWeb.Telemetry,
      TuneUp.Repo,
      {DNSCluster, query: Application.get_env(:tune_up, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TuneUp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TuneUp.Finch},
      # Start a worker by calling: TuneUp.Worker.start_link(arg)
      # {TuneUp.Worker, arg},
      # Start to serve requests, typically the last entry
      TuneUpWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TuneUp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TuneUpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
