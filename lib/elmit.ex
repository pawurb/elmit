require HTTPotion
require Logger

defmodule Elmit do
  def main(_args) do
    IO.puts "Hello elmit!"
    HTTPotion.get("http://dupa.pl") |> handle_response
  end

  # def request(id, url) do
  #   try do
  #     HTTPoison.get(url) |> handle_response(id)
  #   rescue
  #     error in HTTPoison.HTTPError ->
  #       Logger.info "#{id}: error (#{inspect error.message})"
  #   end
  # end

  defp handle_response(response) do
    IO.puts "#{response.body}: success"
  end

  # defp handle_response(%HTTPoison.Response{status_code: status_code}, id) do
  #   Logger.info "#{id}: error (#{status_code})"
  # end
end
