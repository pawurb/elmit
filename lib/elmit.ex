require HTTPotion
require Logger

defmodule Elmit do

  def main(args) do
    IO.puts "Hello elmit!"
    opts = parse_args(args)

    opts
    |> construct_url
    |> issue_request
    |> handle_response
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [from: :string, to: :string, text: :string]
    )
    options
  end

  # def request(id, url) do
  #   try do
  #     HTTPoison.get(url) |> handle_response(id)
  #   rescue
  #     error in HTTPoison.HTTPError ->
  #       Logger.info "#{id}: error (#{inspect error.message})"
  #   end
  # end

  defp construct_url(opts) do
    host = "https://translate.google.com"
    url = "#{host}/translate_a/single?client=t&sl=#{opts[:from]}&tl=#{opts[:to]}&hl=pl&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=at&ie=UTF-8&oe=UTF-8&otf=2&srcrom=1&ssel=3&tsel=6&kc=2&tk=522578&q=#{opts[:text]}"
    IO.puts url
    url
  end

  defp issue_request(url) do
    HTTPotion.get(url)
  end

  defp handle_response(response) do
    IO.puts "#{response.body}"
  end

  # defp handle_response(%HTTPoison.Response{status_code: status_code}, id) do
  #   Logger.info "#{id}: error (#{status_code})"
  # end
end
