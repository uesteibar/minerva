# Minerva

[![Hex Version](https://img.shields.io/hexpm/v/minerva.svg)](https://hex.pm/packages/minerva)

Minerva is a framework for [Elixir](http://elixir-lang.org/) that will allow you to easily write koans.

With very little setup, it will allow you to write koans in plain elixir and run them automagically every time the user modifies the file.

## Index

- [Installation](#installation)
- [Usage](#usage)
- [Running Locally](#running-locally)
- [Contributing](#contributing)
- [Credits](#credits)

## Installation

Add `minerva` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:minerva, "~> 0.1.1"}]
end
```

## Usage

Add it to your supervision tree, passing a list of your koan modules as argument.

In your `application.ex` file (If you're in a supervised project):
```elixir
def start(_type, _args) do
  import Supervisor.Spec, warn: false

  children = [
    worker(Minerva, [[MyApp.AwesomeKoan]]),
  ]

  opts = [strategy: :one_for_one, name: MyApp.Supervisor]
  Supervisor.start_link(children, opts)
end
```

Or you can just start up the server with:
```elixir
Minerva.start_link([MyApp.AwesomeKoan])
```

In your `config.exs` file, let `minerva` know where your koans live:
```elixir
config :minerva, files: "lib/my_app/koans"
```

Now you can start writing *koans*:
```elixir
defmodule MyApp.AwesomeKoan do
  use Minerva.Koans

  koan "You can use variables" do
    var = ___

    assert 1 == var
  end

  koan "You can add numbers" do
    assert 1 + 3 == ___
  end
end
```

See that `___` represents a gap the user should fill to make the koan pass.

You can now run your project with
```
mix run --no-halt
```

And enjoy!

Documentation can be found on [HexDocs](https://hexdocs.pm/minerva).

## Running locally

Clone the repository
```bash
git clone git@github.com:uesteibar/minerva.git
```

Install dependencies
```bash
cd minerva && mix deps.get
```

To run the tests
```bash
mix test
```

To run the lint
```elixir
mix credo
```

## Contributing

Pull requests are always welcome =)

The project uses [standard-changelog](https://github.com/conventional-changelog/conventional-changelog) to update the [Changelog](https://github.com/uesteibar/minerva/blob/master/CHANGELOG.md) with each commit message and upgrade the package version.
For that reason every contribution should have a title and body that follows the [conventional commits standard](https://conventionalcommits.org/) conventions (e.g. `feat(runner): Make it smarter than Jarvis`).

To make this process easier, you can do the following:

Install `commitizen` and `cz-conventional-changelog` globally
```bash
npm i -g commitizen cz-conventional-changelog
```

Save `cz-conventional-changelog` as default
```bash
echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc
```

Instead of `git commit`, you can now run
```
git cz
```
and follow the instructions to generate the commit message.

## Credits

Thanks to [elixir-koans](https://github.com/elixirkoans/elixir-koans) for the inspiration.
