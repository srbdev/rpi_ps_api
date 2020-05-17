defmodule RainmeterRpi4bApiTest do
  use ExUnit.Case
  doctest RainmeterRpi4bApi

  test "greets the world" do
    assert RainmeterRpi4bApi.hello() == :world
  end
end
