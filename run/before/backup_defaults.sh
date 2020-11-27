#! /bin/sh
set -o errexit -o nounset

# Back up macOS default settings before changing
defaults read > ~/Documents/macos-defaults.txt
