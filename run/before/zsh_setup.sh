#!/bin/sh
set -o errexit -o nounset

if cd "${HOME}/.zgenom"; then git pull; else git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"; fi
