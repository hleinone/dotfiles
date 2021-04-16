#!/bin/sh
set -o errexit -o nounset

curl -fsSL https://starship.rs/install.sh | bash

if cd "${HOME}/.zgen"; then git pull; else git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"; fi

