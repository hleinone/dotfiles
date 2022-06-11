#!/bin/sh
set -o errexit -o nounset

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Helsinki" > /dev/null

# Show the ~/Library folder
chflags nohidden ~/Library

# Install Rosetta, else apply-user-defaults will fail
if [[ $(uname -m) == 'arm64' ]]; then
  softwareupdate --install-rosetta
fi