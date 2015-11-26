require HTTPotion
require Logger

defmodule Elmit do
  @host "https://translate.google.com"

  def main(args) do
    opts = args
    |> parse_args

    response = opts
    |> construct_text_url
    |> HTTPotion.get

    translation = handle_text_response(response, opts)
    IO.puts translation
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

  defp construct_text_url(opts) do
    "#{@host}/translate_a/single?client=t&sl=#{opts[:from]}&tl=#{opts[:to]}&hl=pl&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=at&ie=UTF-8&oe=UTF-8&otf=2&srcrom=1&ssel=3&tsel=6&kc=2&tk=522578&q=#{URI.encode(opts[:text])}"
  end

  defp handle_text_response(%HTTPotion.Response{body: body}, opts) do
    translation = body
    |> String.split("[[")
    |> tl
    |> List.first
    |> String.split("\"")
    |> tl
    |> List.first

    if opts[:s] do
      raw_synonyms = body
      |> String.split("[[")
      |> tl
      |> List.last

      synonyms = if String.contains?(raw_synonyms, "[") do
        '---'
      else
        raw_synonyms
        |> String.rstrip(?])
        |> String.replace(",\"", " ")
        |> String.replace("\"", ",")
        |> String.rstrip(?,)
        |> String.lstrip(?,)
      end
      "=> #{translation}
=> Synonyms: #{synonyms}"
    else
      "=> #{translation}"
    end
  end
end
