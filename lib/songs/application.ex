defmodule Songs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SongsWeb.Telemetry,
      # Start the Ecto repository
      Songs.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Songs.PubSub},
      # Start Finch
      {Finch, name: Songs.Finch},
      # Start the Endpoint (http/https)
      SongsWeb.Endpoint
      # Start a worker by calling: Songs.Worker.start_link(arg)
      # {Songs.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Songs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SongsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
