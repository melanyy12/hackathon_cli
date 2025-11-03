defmodule HackathonCliTest do
  use ExUnit.Case
  doctest HackathonCli

  test "greets the world" do
    assert HackathonCli.hello() == :world
  end
end
