# Wavely project

## Installing developer tools required

* Install nix-shell on your local system (<https://nixos.org/download.html>)
* Add the appropriate nix channel. Current is 23.05 `nix-channel --add https://nixos.org/channels/nixos-23.05 nixos-23.05`
* Update with `nix-channel --update`
* Run `nix-shell` within the root of the project. This will change you into the nix-shell environment with all the necessary packages required, at the correct version level, to run the project.

Note: Nix will never override or otherwise conflict with local packages.

## Running

To start your Phoenix server:

* Run `nix-shell` within the root of the project.
* Install dependencies with `mix deps.get`
* Have all the static assets setup with `mix assets.setup`
* Start a Phoenix endpoint w/ iex console with `MIX_ENV="dev" iex -S mix phx.server`

Visit <http://localhost:4000/upload> to view the file uploading tool.

Use priv/tada.wav as a test file.
