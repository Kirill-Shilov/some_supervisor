defmodule Crash.Top do
  @moduledoc """
  supervisor for Middleware
  """
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    IO.puts "Top init"
    children = [
      Supervisor.child_spec({Crash.Middleware, []}, id: :w1),
      Supervisor.child_spec({Crash.Middleware, []}, id: :w2),
      Supervisor.child_spec({Crash.Middleware, []}, id: :w3)
    ]

    opts = [
      strategy: :one_for_one,
      max_restarts: 300,
    ]

    Supervisor.init(children, opts)
  end
end
