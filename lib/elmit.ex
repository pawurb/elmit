defmodule Elmit do
  @host "https://translate.google.com"

  def main(args) do
    opts = parse_args(args)

    response = opts
    |> filter_keys([:from, :to, :text])
    |> build_text_url
    |> fetch

    translation = extract_translation(response)
    synonyms = if opts[:s] do
      extract_synonyms(response)
    else
      ""
    end

    IO.puts "=> #{translation} #{synonyms}"

    if opts[:t] do
      opts
      |> filter_keys([:to, :text])
      |> List.keyreplace(:text, 0, {:text, translation})
      |> build_sound_url
      |> fetch
      |> handle_sound_response
    end
  end

  def fetch(url) do
    try do
      HTTPotion.get(url)
    rescue
      HTTPotion.HTTPError ->
      Elmit.OutputManager.connection_problem
      System.halt(1)
    end
  end

  def parse_args([]) do
    Elmit.OutputManager.long_help
    System.halt(0)
  end

  def parse_args([_]) do
    Elmit.OutputManager.wrong_data
    System.halt(0)
  end

  def parse_args([_, _]) do
    Elmit.OutputManager.wrong_data
    System.halt(0)
  end

  def parse_args(args) do
    Elmit.InputParser.call(args)
  end

  defp build_text_url([from: from, to: to, text: text]) do
    "#{@host}/translate_a/single?client=t&sl=#{from}&tl=#{to}&hl=pl&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=at&ie=UTF-8&oe=UTF-8&otf=2&srcrom=1&ssel=3&tsel=6&kc=2&tk=522578&q=#{URI.encode(text)}"
  end

  defp build_sound_url([to: to, text: text]) do
    "#{@host}/translate_tts?ie=UTF-8&tl=#{to}&total=1&idx=0&textlen=5&tk=735012&client=t&q=#{URI.encode(text)}"
  end

  defp extract_translation(%{ body: body }) do
    body
    |> String.split("[[")
    |> tl
    |> List.first
    |> String.split("\"")
    |> tl
    |> List.first
  end

  defp extract_synonyms(%{ body: body }) do
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

  defp handle_sound_response(%{ body: body }) do
    path = "~/.elmit"
    expanded_path = Path.expand(path)
    if !File.exists?(expanded_path) do
      File.mkdir!(expanded_path)
    end

    file_path = Path.expand("#{path}/sound.mpeg")
    File.write(file_path, body, [:binary])
    try do
      System.cmd("mpg123", [file_path], stderr_to_stdout: true)
    rescue
      ErlangError ->
      Elmit.OutputManager.missing_sound_player
      System.halt(0)
    end
  end

  defp filter_keys(list, keys) do
    list
    |> Enum.filter(fn(x) -> Enum.member?(keys, elem(x, 0)) end)
  end
end
