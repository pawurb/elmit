defmodule Elmit.InputParser do
  def call(args) do
    [non_flags, flags] = seperate_flags(args)
    preparsed = [
      "--from=#{non_flags |> List.first}",
      "--to=#{non_flags |> Enum.slice(1,1) |> List.first}",
      "--text=#{non_flags |> Enum.slice(2,100) |> Enum.join(" ")}",
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
    options |> Enum.reject(fn(arg) -> elem(arg, 1) == "" end)
  end

  defp seperate_flags(list) do
    flas_selector = fn(arg) ->
      arg == "-t" || arg == "-s" || arg == "-h"
    end
    non_flags = list |> Enum.reject(flas_selector)
    flags = list |> Enum.filter(flas_selector)

    [non_flags, flags]
  end
end
