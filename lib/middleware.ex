defmodule Crash.Middleware do
  @moduledoc """
  supervisor for Crashy
  """
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, [], init_arg)
  end

  @impl true
  def init(_init_arg) do
    IO.puts "Middleware init"
    children = [
      Supervisor.child_spec({Crash.Crashy, []}, [])
    ]

    opts = [
      strategy: :one_for_one,
      max_restarts: 300
    ]

    Supervisor.init(children, opts)
  end
end

