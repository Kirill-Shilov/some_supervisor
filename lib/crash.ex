defmodule Crash do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Supervisor.start_link(
      [
        Crash.Top,
        Crash.Loop
      ],
      strategy: :one_for_one
    )
  end
end

