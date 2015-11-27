require HTTPotion
require Logger

defmodule Elmit do
  @host "https://translate.google.com"

  def main(args) do
    opts = parse_args(args)

    response = opts
    |> construct_text_url
    |> HTTPotion.get

    translation = extract_translation(response)
    synonyms = if opts[:s] do
      extract_synonyms(response)
    else
      ""
    end

    IO.puts "=> #{translation} #{synonyms}"

    if opts[:t] do
      sound_opts = List.keydelete(opts, :text, 0) ++ [text: translation]
      sound_opts
      |> construct_sound_url
      |> HTTPotion.get
      |> handle_sound_response
    end
  end

  def parse_args([]) do
"""
=========ELMIT=========
Usage:
elmit 'source_language' 'target_language' 'text'

Example:
elmit en fr 'hey cowboy where is your horse?'
=> 'hey cow-boy ou est votre cheval?'

Options:
-t - speech synthesis
-s - synonyms list

Check docs at: github.com/pawurb/elmit
""" |> IO.puts
    System.halt(0)
  end

  def parse_args([_]) do
    display_short_help
    System.halt(0)
  end

  def parse_args([_, _]) do
    display_short_help
    System.halt(0)
  end

  defp display_short_help do
"""
ELMIT: Wrong data. Example: 'elmit en es the cowboy' => 'el vaquero'
""" |> IO.puts
  end

  def parse_args(args) do
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

  defp construct_text_url(opts) do
    "#{@host}/translate_a/single?client=t&sl=#{opts[:from]}&tl=#{opts[:to]}&hl=pl&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=at&ie=UTF-8&oe=UTF-8&otf=2&srcrom=1&ssel=3&tsel=6&kc=2&tk=522578&q=#{URI.encode(opts[:text])}"
  end

  defp construct_sound_url(opts) do
    "#{@host}/translate_tts?ie=UTF-8&tl=#{opts[:to]}&total=1&idx=0&textlen=5&tk=735012&client=t&q=#{URI.encode(opts[:text])}"
  end

  defp extract_translation(%HTTPotion.Response{body: body}) do
    body
    |> String.split("[[")
    |> tl
    |> List.first
    |> String.split("\"")
    |> tl
    |> List.first
  end

  defp extract_synonyms(%HTTPotion.Response{body: body}) do
      raw_synonyms = body
      |> String.split("[[")
      |> tl
      |> tl
      |> List.first
      |> String.split("[")
      |> List.last
      |> String.split(",")
      |> Enum.join(", ")
      |> String.replace(",,", ",")

      synonyms = if String.contains?(raw_synonyms, "1") do
        '---'
      else
        raw_synonyms
        |> String.rstrip(?])
        |> String.replace("]", "")
        |> String.replace(",,", ",")
        |> String.replace(",\"", " ")
        |> String.replace("\"", ",")
        |> String.rstrip(?,)
        |> String.lstrip(?,)
        |> String.replace(",,", ",")
        |> String.replace(" ,", " ")
      end
      "\n=> Synonyms: #{synonyms}"
  end

  defp handle_sound_response(%HTTPotion.Response{body: body}) do
    path = "~/.elmit"
    expanded_path = Path.expand(path)
    if !File.exists?(expanded_path) do
      File.mkdir!(expanded_path)
    end

    file_path = Path.expand("#{path}/sound.mpeg")
    File.write(file_path, body, [:binary])
    System.cmd("mpg123", [file_path], stderr_to_stdout: true)
  end
end
