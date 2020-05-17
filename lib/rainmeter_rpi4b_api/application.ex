defmodule RainmeterRpi4bApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: ApiRouter, options: [port: 4001])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RainmeterRpi4bApi.Supervisor]
    Logger.info("Starting application...")
    Supervisor.start_link(children, opts)
  end
end
