defmodule AmigoBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AmigoBackendWeb.Telemetry,
      AmigoBackend.Repo,
      {DNSCluster, query: Application.get_env(:amigo_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AmigoBackend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AmigoBackend.Finch},
      # Start a worker by calling: AmigoBackend.Worker.start_link(arg)
      # {AmigoBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      AmigoBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AmigoBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AmigoBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
