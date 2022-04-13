#!/bin/sh
set -o errexit -o nounset

curl -sS https://starship.rs/install.sh | sh

if cd "${HOME}/.zgenom"; then git pull; else git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"; fi
