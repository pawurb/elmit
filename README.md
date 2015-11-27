# Elmit

Google Translate with speech synthesis in your terminal as Hex package.

## Installation

* `brew install elixir`
* `mix deps.get`
* `mix escript.build`
* `ln ./elmit /usr/local/bin`

## Usage
```elixir
elmit 'source_language' 'target_language' 'text'
```

Example:

```elixir

elmit en es "hey cowboy where is your horse?"
=> "Hey vaquero dónde está tu caballo?"

elmit fr en "qui est votre papa?"
=> "Who's Your Daddy?"
```

#### Speech synthesis

Specify a **-t** (talk) flag to use speech synthesis (requires mpg123):
``` elixir
elmit en zh "hey cowboy where is your horse?" -t
=> "嘿，牛仔是你的马在哪里？" # and a chinese voice says something about a horse
```

You can use elmit as a speech synthesizer of any supported language without having to translate anything:
``` elixir
elmit en en "hold your horses cowboy !" -t
=> "hold your horses cowboy !" # and an english voice asks you to hold on
```

#### Synonyms

Specify a **-s** (synonyms) flag to get the list of synonyms if available:
``` elixir
elmit es en muchacho -s
=> boy
=> Synonyms: boy, lad, youngster, laddie, cully
```

## Requirements

To use speech synthesis you need to have mpg123 installed.

For Ubuntu:

    sudo apt-get install mpg123

For MacOSX:

    brew install mpg123

