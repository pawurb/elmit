defmodule Elmit.InputParser do
  def call(args) do
    preparsed = [
      "--from=#{args |> List.first}",
      "--to=#{args |> tl |> List.first}",
      "--text=#{args |> tl |> tl |> List.first}",
    ] ++ (args |> Enum.slice(3, 2) |> Enum.map(fn(x) -> "-#{x}" end))

    {options, _, _} = OptionParser.parse(preparsed,
      switches: [
        from: :string,
        to: :string,
        text: :string,
        t: :boolean,
        s: :boolean
      ]
    )
    options
  end
end
