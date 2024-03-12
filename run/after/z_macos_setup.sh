#!/bin/sh
set -o errexit -o nounset

REPOS_DIR="$(mktemp -d -t macos_setup_repos)"

trap 'rm -rf "$REPOS_DIR"' EXIT
(
    >&2 echo "Installing PAM Touch ID…"
    cd "$REPOS_DIR"
    set -x
    git clone https://github.com/Reflejo/pam-touchID.git
    cd pam-touchID
    sudo make install
    grep -Fxq 'auth       sufficient     pam_touchid.so "reason=execute a command as root"' /etc/pam.d/sudo || sudo sed -i '' '1i\'$'\n''auth       sufficient     pam_touchid.so "reason=execute a command as root"' /etc/pam.d/sudo
    set +x
)

# Install ESP-IDF
>&2 echo "Installing ESP-IDF…"
mkdir -p ~/esp
if cd "${HOME}/esp/esp-idf"; then git pull; else git clone --recursive https://github.com/espressif/esp-idf.git "${HOME}/esp/esp-idf"; fi
~/esp/esp-idf/install.sh

# File type associations for Sublime Text
duti -s com.sublimetext.4 .md all
duti -s com.sublimetext.4 .xml all
duti -s com.sublimetext.4 .txt all
duti -s com.sublimetext.4 .json all
duti -s com.sublimetext.4 .gpx all
duti -s com.sublimetext.4 .conf all
duti -s com.sublimetext.4 .csv all
duti -s com.sublimetext.4 .sh all
duti -s com.sublimetext.4 .yaml all
duti -s com.sublimetext.4 .properties all
duti -s com.sublimetext.4 .gradle all
duti -s com.sublimetext.4 .kt all
duti -s com.sublimetext.4 .java all
duti -s com.sublimetext.4 .json all
duti -s com.sublimetext.4 .strings all
duti -s com.sublimetext.4 .swift all
duti -s com.sublimetext.4 .h all
duti -s com.sublimetext.4 .c all
duti -s com.sublimetext.4 .cpp all
duti -s com.sublimetext.4 .m all
duti -s com.sublimetext.4 .mm all
duti -s com.sublimetext.4 .cmake all
duti -s com.sublimetext.4 .pch all
duti -s com.sublimetext.4 .plist all
duti -s com.sublimetext.4 LICENSE all
duti -s com.sublimetext.4 .py all
duti -s com.sublimetext.4 Podfile all
duti -s com.sublimetext.4 Brewfile all
duti -s com.sublimetext.4 .rst all
duti -s com.sublimetext.4 .js all
duti -s com.sublimetext.4 .ts all
duti -s com.sublimetext.4 .go all
duti -s com.sublimetext.4 .gitignore all
duti -s com.sublimetext.4 .gitconfig all
duti -s com.sublimetext.4 .zshrc all
duti -s com.sublimetext.4 .bashrc all
duti -s com.sublimetext.4 .toml all
duti -s com.sublimetext.4 .bat all
duti -s com.sublimetext.4 .svg all
duti -s com.sublimetext.4 .pom all
duti -s com.sublimetext.4 .proto all
duti -s com.sublimetext.4 .log all

# File type associations for VLC
duti -s org.videolan.vlc .wav all
duti -s org.videolan.vlc .3gp all
duti -s org.videolan.vlc .webm all

>&2 echo ""
>&2 echo "\033[0;32mInstall Additional Tools for Xcode from: https://developer.apple.com/download/more/\033[0m"
>&2 echo "\033[0;32mInstall Font Tools for Xcode from: https://developer.apple.com/download/all/?q=font\033[0m"
>&2 echo "\033[0;32mInstall Android Studio, AppCode etc. from Jetbrains Toolbox\033[0m"
>&2 echo ""
>&2 echo "\033[0;32mTurn on VSCode settings sync\033[0m"
>&2 echo "\033[0;32mTurn on BetterTouchTool settings sync\033[0m"
>&2 echo "\033[0;32mTurn on Android Studio & AppCode settings sync\033[0m"
