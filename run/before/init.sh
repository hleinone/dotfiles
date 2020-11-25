#! /bin/sh
# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Helsinki" >/dev/null

# Show the ~/Library folder
chflags nohidden ~/Library
