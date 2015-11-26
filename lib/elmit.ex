require HTTPotion
require Logger

defmodule Elmit do

  def main(args) do
    opts = args
    |> parse_args

    translation = opts
    |> construct_url
    |> issue_request
    |> handle_response
    IO.puts "=> #{translation}"
    if opts[:t] do
      IO.puts "play sound"
    else
      IO.puts "no sound"
    end
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [from: :string, to: :string, text: :string],
      strict: [t: :boolean]
    )
    options
  end

  defp construct_url(opts) do
    host = "https://translate.google.com"
    "#{host}/translate_a/single?client=t&sl=#{opts[:from]}&tl=#{opts[:to]}&hl=pl&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=at&ie=UTF-8&oe=UTF-8&otf=2&srcrom=1&ssel=3&tsel=6&kc=2&tk=522578&q=#{opts[:text]}"
  end

  defp issue_request(url) do
    HTTPotion.get(url)
  end

  defp handle_response(%HTTPotion.Response{body: body}) do
    body
    |> String.split("[[")
    |> tl
    |> List.first
    |> String.split("\"")
    |> tl
    |> List.first
  end
end
