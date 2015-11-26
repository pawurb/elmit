defmodule ElmitTest do
  use ExUnit.Case
  doctest Elmit

  test "universe works" do
    assert 1 + 1 == 2
  end

  test "parsing user input" do
    user_args = ["--from=pl", "--to=es", "--text=dzień dobry panu", "--t"]
    expected = [from: "pl", to: "es", text: "dzień dobry panu", t: true]
    parsed = Elmit.parse_args(user_args)
    assert parsed == expected
  end
end
