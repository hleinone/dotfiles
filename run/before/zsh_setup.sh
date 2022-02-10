#!/bin/sh
set -o errexit -o nounset

curl -fsSL https://starship.rs/install.sh | bash

if cd "${HOME}/.zgenom"; then git pull; else git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"; fi
