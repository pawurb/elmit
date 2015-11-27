defmodule Elmit.InputParser do
  def call(args) do
    [non_flags, flags] = seperate_flags(args)
    preparsed = [
      "--from=#{non_flags |> List.first}",
      "--to=#{non_flags |> tl |> List.first}",
      "--text=#{non_flags |> tl |> tl |> Enum.join(" ")}",
    ] ++ (flags |> Enum.map(fn(x) -> "-#{x}" end))

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

  defp seperate_flags(list) do
    separator = fn(arg) ->
      arg == "-t" || arg == "-s"
    end
    non_flags = list |> Enum.reject(separator)
    flags = list |> Enum.filter(separator)

    [non_flags, flags]
  end
end
