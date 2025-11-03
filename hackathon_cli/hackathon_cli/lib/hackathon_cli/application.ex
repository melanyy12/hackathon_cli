defmodule HackathonCli.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Arranca el ChatServer como child (usa la child spec generada por GenServer)
      {HackathonCli.Adapters.ChatServer, []}
      # agrega aquí otros workers/supervisores si los tienes
    ]

    opts = [strategy: :one_for_one, name: HackathonCli.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
