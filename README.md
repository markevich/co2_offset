![Travis](https://travis-ci.com/markevich/co2_offset.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/github/markevich/co2_offset/badge.svg?branch=master)](https://coveralls.io/github/markevich/co2_offset?branch=master)

---

# CO2 offset

Offset your carbon footpring

- [CO2 offset](#CO2-offset)
  - [Install development environment](#Install-development-environment)


## Install development environment
1. Install [ASDF](https://github.com/asdf-vm/asdf).
1. Install [Erlang](https://github.com/asdf-vm/asdf-erlang) ASDF plugin
   - Install Erlang [Requirements](https://github.com/asdf-vm/asdf-erlang#before-asdf-install)
   - `asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git`
   - `export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"`
1. Install [Elixir](https://github.com/asdf-vm/asdf-elixir) ASDF plugin
   - `asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`
1. Install [Nodejs](https://github.com/asdf-vm/asdf-nodejs) ASDF plugin
   - Install Nodejs [Requirements](https://github.com/asdf-vm/asdf-nodejs#requirements)
   - `asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git`
   - `bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring`
1. CD into project folder
1. Install Erlang:
   - `asdf install`
1. Install Elixir:
   - `asdf install`
1. Install Nodejs:
   - `asdf install`
1. Reopen your shell.
1. Copy example configs:
   - `cp config/dev.secret.exs.example config/dev.secret.exs`
   - `cp config/test.secret.exs.example config/test.secret.exs`
1. Install Phoenix 1.4.9.
   - `mix archive.install hex phx_new 1.4.9`
1. Create a db-user for aplication in `psql` console:
   - `CREATE ROLE username LOGIN PASSWORD 'password' SUPERUSER;`
1. Configure DB parameters in
   -  `config/dev.secret.exs`
   -  `config/test.secret.exs`
1. Run:
   - `mix deps.get`
   - `mix deps.compile`
   - `mix ecto.setup`
   - `cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development && cd ../`
1. Configure git hooks:
   - `chmod -v -R +x .githooks`
   - `git config core.hooksPath .githooks`
1. Run the server: `mix phx.server`.
1. Go to `localhost:4000`
