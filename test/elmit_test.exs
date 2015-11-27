defmodule ElmitTest do
  use ExUnit.Case
  doctest Elmit

  test "parsing user input" do
    user_args = ["pl", "es", "dzień dobry panu", "-t", "-s"]
    expected = [from: "pl", to: "es", text: "dzień dobry panu", t: true, s: true]
    parsed = Elmit.parse_args(user_args)
    assert parsed == expected
  end
end
