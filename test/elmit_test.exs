defmodule ElmitTest do
  use ExUnit.Case, async: false
  import Mock

  test "parsing user input" do
    user_args = ["pl", "es", "dzień dobry panu", "-t", "-s"]
    expected = [from: "pl", to: "es", text: "dzień dobry panu", t: true, s: true]
    parsed = Elmit.parse_args(user_args)
    assert parsed == expected
  end

  test "full flow does not raise error" do
    mocked_responses = fn(url) ->
      cond do
        url =~ ~r/translate_a/ ->
          body = File.read!("./test/fixtures/google_response")
          %{ body:  body }
        url =~ ~r/translate_tts/ ->
          %{ body: "mocked_sound_response" }
        true ->
          raise "Issued not mocked request in the tests"
      end
    end

    with_mock HTTPotion, [get: mocked_responses] do
      Elmit.main(["en", "es", "hello", "-t", "-s"])
      assert true == true
    end
  end
end
