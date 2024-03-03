defmodule Crash.Loop do
  @moduledoc """
  get list of Crashy and send :tick to each in loop
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init([]) do
    IO.puts "Loop init"
    send(self(), :tick)
    {:ok, []}
  end

  @impl true
  def handle_info(:tick, state) do
    IO.puts "Loop tick"
    tick_maker()
    {:noreply, state}
  end

  defp tick_maker do
    for i <- Supervisor.which_children(Crash.Top) do
      case i do
        {_, j, _, _} ->
          case Supervisor.which_children(j) do
            [{_, k, _, _}] ->
              IO.inspect k
              #GenServer.call(k, :tick)
              GenServer.cast(k, :tick)
            _ -> IO.puts "No crashy"
          end
        _ -> IO.puts "No middleware"
      end
    end
    :timer.sleep(100)
    send(self(), :tick)
  end
end
