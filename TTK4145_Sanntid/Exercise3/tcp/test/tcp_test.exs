defmodule TCPTest do
  use ExUnit.Case
  doctest TCP

  test "greets the world" do
    assert TCP.hello() == :world
  end
end
