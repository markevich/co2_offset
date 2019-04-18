![Travis](https://travis-ci.com/markevich/co2_offset.svg?branch=master)
==========
# CO2 offset

Offset your carbon footpring

- [!Travis](#travis)
- [CO2 offset](#co2-offset)
  - [Install development environment](#install-development-environment)


## Install development environment
- Install [ASDF](https://github.com/asdf-vm/asdf).
- Install [Erlang](https://github.com/asdf-vm/asdf-erlang) ASDF plugin
  - Install Erlang [Requirements](https://github.com/asdf-vm/asdf-erlang#before-asdf-install)
  - `asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git`
  - `export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"`
- Install [Elixir](https://github.com/asdf-vm/asdf-elixir) ASDF plugin
  - `asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`
- Install [Nodejs](https://github.com/asdf-vm/asdf-nodejs) ASDF plugin
  - Install Nodejs [Requirements](https://github.com/asdf-vm/asdf-nodejs#requirements)
  - `asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git`
  - `bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring`
- CD into project folder
- Install Erlang:
  - `asdf install`
- Install Elixir:
  - `asdf install`
- Install Nodejs:
  - `asdf install`
- Reopen your shell.
- Copy example configs:
  - `cp config/dev.secret.exs.example config/dev.secret.exs`
  - `cp config/test.secret.exs.example config/test.secret.exs`
- Install Phoenix 1.4.1.
  - `mix archive.install hex phx_new 1.4.1`
- Create a db-user for aplication in `psql` console:
  - `CREATE ROLE username LOGIN PASSWORD 'password' SUPERUSER;`
- Configure DB parameters in
  -  `config/dev.secret.exs`
  -  `config/test.secret.exs`
- Run:
  - `mix deps.get`
  - `mix deps.compile`
  - `mix ecto.setup`
  - `cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development && cd ../`
- Configure git hooks:
  - `chmod -v -R +x .githooks`
  - `git config core.hooksPath .githooks`
- Run the server: `mix phx.server`.
- Go to `localhost:4000`
