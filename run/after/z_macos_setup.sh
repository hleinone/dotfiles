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
    grep -Fxq 'auth       sufficient     pam_touchid.so "reason=execute a command as root"' /etc/pam.d/sudo || printf '2iauth       sufficient     pam_touchid.so "reason=execute a command as root"\n' | sudo sed -i -f - /etc/pam.d/sudo
    set +x
)

# Install ESP-IDF
>&2 echo "Installing ESP-IDF…"
mkdir -p ~/esp
if cd "${HOME}/esp/esp-idf"; then git pull; else git clone --recursive https://github.com/espressif/esp-idf.git "${HOME}/esp/esp-idf"; fi
~/esp/esp-idf/install.sh

# File type associations for Zed
duti -s dev.zed.Zed .md all
duti -s dev.zed.Zed .xml all
duti -s dev.zed.Zed .txt all
duti -s dev.zed.Zed .json all
duti -s dev.zed.Zed .gpx all
duti -s dev.zed.Zed .conf all
duti -s dev.zed.Zed .csv all
duti -s dev.zed.Zed .sh all
duti -s dev.zed.Zed .yaml all
duti -s dev.zed.Zed .properties all
duti -s dev.zed.Zed .gradle all
duti -s dev.zed.Zed .kt all
duti -s dev.zed.Zed .java all
duti -s dev.zed.Zed .json all
duti -s dev.zed.Zed .strings all
duti -s dev.zed.Zed .swift all
duti -s dev.zed.Zed .h all
duti -s dev.zed.Zed .c all
duti -s dev.zed.Zed .cpp all
duti -s dev.zed.Zed .m all
duti -s dev.zed.Zed .mm all
duti -s dev.zed.Zed .cmake all
duti -s dev.zed.Zed .pch all
duti -s dev.zed.Zed .plist all
duti -s dev.zed.Zed LICENSE all
duti -s dev.zed.Zed .py all
duti -s dev.zed.Zed Podfile all
duti -s dev.zed.Zed Brewfile all
duti -s dev.zed.Zed .rst all
duti -s dev.zed.Zed .js all
duti -s dev.zed.Zed .ts all
duti -s dev.zed.Zed .go all
duti -s dev.zed.Zed .gitignore all
duti -s dev.zed.Zed .gitconfig all
duti -s dev.zed.Zed .zshrc all
duti -s dev.zed.Zed .bashrc all
duti -s dev.zed.Zed .toml all
duti -s dev.zed.Zed .bat all
duti -s dev.zed.Zed .svg all
duti -s dev.zed.Zed .pom all
duti -s dev.zed.Zed .proto all
duti -s dev.zed.Zed .log all

# File type associations for VLC
duti -s org.videolan.vlc .wav all
duti -s org.videolan.vlc .3gp all
duti -s org.videolan.vlc .webm all
duti -s org.videolan.vlc .m3u all

# Configure and install development tools using Mise-en-place
mise settings add idiomatic_version_file true
mise settings add idiomatic_version_file_enable_tools node
mise settings add idiomatic_version_file_enable_tools flutter
mise settings ruby.compile=false
mise plugins install https://github.com/nyuyuyu/asdf-flutter.git
mise use --global java@latest
mise use --global node@latest
mise use --global python@latest
mise use --global ruby@latest
mise use --global flutter@latest

>&2 echo ""
>&2 echo "\033[0;32mInstall Additional Tools for Xcode from: https://developer.apple.com/download/more/\033[0m"
>&2 echo "\033[0;32mInstall Font Tools for Xcode from: https://developer.apple.com/download/all/?q=font\033[0m"
>&2 echo "\033[0;32mInstall Android Studio, AppCode etc. from Jetbrains Toolbox\033[0m"
>&2 echo ""
>&2 echo "\033[0;32mTurn on VSCode settings sync\033[0m"
>&2 echo "\033[0;32mTurn on BetterTouchTool settings sync\033[0m"
>&2 echo "\033[0;32mTurn on Android Studio & AppCode settings sync\033[0m"
