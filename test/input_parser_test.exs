defmodule InputParserTest do
  use ExUnit.Case

  test "parsing user input" do
    user_args = ["pl", "es", "dzień dobry panu", "-t", "-s"]
    expected = [from: "pl", to: "es", text: "dzień dobry panu", t: true, s: true]
    parsed = Elmit.InputParser.call(user_args)
    assert parsed == expected
  end

  test "parsing user input not wrapped by parenthesis" do
    user_args = ["pl", "es", "dzień", "dobry", "panu", "-t", "-s"]
    expected = [from: "pl", to: "es", text: "dzień dobry panu", t: true, s: true]
    parsed = Elmit.InputParser.call(user_args)
    assert parsed == expected
  end

end
