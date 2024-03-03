defmodule CrashTest do
  use ExUnit.Case
  doctest Crash

  test "greets the world" do
    assert Crash.hello() == :world
  end
end
