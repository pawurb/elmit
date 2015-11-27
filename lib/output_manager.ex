defmodule Elmit.OutputManager do
  def long_help do
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
""" |> IO.write
  end

  def wrong_data do
"""
ELMIT: Wrong data. Example: 'elmit en es the cowboy' => 'el vaquero'
""" |> IO.write
  end

  def connection_problem do
"""
ELMIT: There seems to be a problem with your internet connection
""" |> IO.write
  end

  def missing_sound_player do
"""
ELMIT: speech synthesis requires mpg123 installed.
Please run 'brew install mpg123'
""" |> IO.write

  end
end
