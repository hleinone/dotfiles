#!/bin/sh
set -o errexit -o nounset

curl -fsSL https://starship.rs/install.sh | bash

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
