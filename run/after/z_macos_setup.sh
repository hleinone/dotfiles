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
    set +x

    cd -
    >&2 echo "Installing PAM Watch ID…"
    set -x
    git clone https://github.com/biscuitehh/pam-watchid.git
    cd pam-watchid
    sudo make install
    set +x
)

>&2 echo "Installing latest Node globally using nodenv…"
LATEST_NODE="$(nodenv install -l | ggrep -E '^[0-9\.]+$' | tail -1)"
nodenv install "$LATEST_NODE"
nodenv global "$LATEST_NODE"

>&2 echo "Installing latest Python globally using pyenv…"
LATEST_PYTHON="$(pyenv install -l | sed 's/^ *//g' | ggrep -E '^[0-9\.]+$' | tail -1)"
pyenv install "$LATEST_PYTHON"
pyenv global "$LATEST_PYTHON"

>&2 echo "Installing latest Ruby globally using rbenv…"
LATEST_RUBY="$(rbenv install -L | ggrep -E '^[0-9\.]+$' | tail -1)"
rbenv install "$LATEST_RUBY"
rbenv global "$LATEST_RUBY"

>&2 echo "Installing latest Go globally using goenv…"
LATEST_GO="$(goenv install -l | sed 's/^ *//g' | ggrep -E '^[0-9\.]+$' | tail -1)"
goenv install "$LATEST_GO"
goenv global "$LATEST_GO"

>&2 echo "Setting up latest Java globally using jenv…"
for java in /Library/Java/JavaVirtualMachines/*; do
  jenv add "$java/Contents/Home/"
done
LATEST_JAVA="$(jenv versions --bare | sed 's/^ *//g' | ggrep -E '^[0-9\.]+$' | tail -1)"
jenv global "$LATEST_JAVA"

# Install Rust
>&2 echo "Installing latest Rust…"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install ESP-IDF
>&2 echo "Installing ESP-IDF…"
mkdir -p ~/esp
git clone --recursive https://github.com/espressif/esp-idf.git ~/esp/esp-idf
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
duti -s com.sublimetext.4 .swift all
duti -s com.sublimetext.4 .h all
duti -s com.sublimetext.4 .cpp all
duti -s com.sublimetext.4 .m all
duti -s com.sublimetext.4 .pch all
duti -s com.sublimetext.4 .plist all
duti -s com.sublimetext.4 LICENSE all
duti -s com.sublimetext.4 .py all
duti -s com.sublimetext.4 Podfile all
duti -s com.sublimetext.4 Brewfile all
duti -s com.sublimetext.4 .js all
duti -s com.sublimetext.4 .ts all
duti -s com.sublimetext.4 .gitignore all
duti -s com.sublimetext.4 .gitconfig all
duti -s com.sublimetext.4 .zshrc all
duti -s com.sublimetext.4 .bashrc all
duti -s com.sublimetext.4 .toml all
duti -s com.sublimetext.4 .bat all
duti -s com.sublimetext.4 .svg all
duti -s com.sublimetext.4 .pom all

# File type associations for VLC
duti -s org.videolan.vlc .wav all
duti -s org.videolan.vlc .3gp all

>&2 echo ""
>&2 echo "\033[0;32mTurbo Boost Switcher Pro from: http://tbswitcher.rugarciap.com/\033[0m"
>&2 echo "\033[0;32mInstall Additional Tools for Xcode from: https://developer.apple.com/download/more/\033[0m"
>&2 echo "\033[0;32mInstall Smart Scroll from: https://www.marcmoini.com/sx_en.html\033[0m"
>&2 echo "\033[0;32mInstall Android Studio, AppCode etc. from Jetbrains Toolbox\033[0m"
>&2 echo ""
>&2 echo "\033[0;32mTurn on VSCode settings sync\033[0m"
>&2 echo "\033[0;32mTurn on BetterTouchTool settings sync\033[0m"
>&2 echo "\033[0;32mTurn on Android Studio & AppCode settings sync\033[0m"
