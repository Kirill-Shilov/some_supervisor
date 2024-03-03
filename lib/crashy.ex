defmodule Crash.Crashy do
  @moduledoc """
  handles messages with :tick and randomly devites by zero
  """
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init([]) do
    {:ok, []}
  end

  #в какой-то момент вариант с call просто прекращает работу на очередном делении на ноль. Возможно я ловлю дэдлок.
  #чтобы посмотреть надо поменять внутри Crash.Loop.tick_maker cast на call
  #  def handle_call(:tick, _from, state) do
  #    IO.puts "before crashy_function"
  #    crashy_function()
  #    {:reply, :ok, state}
  #  end

  def handle_cast(:tick, state) do
    crashy_function()
    {:noreply, state}
  end

  defp crashy_function() do
    d = Enum.random(0..10)
    if d == 0 do
      IO.puts "Divide by zero"
    else
      IO.puts "devide by #{d}"
    end
    :erlang.div(1, d)
  end
end
