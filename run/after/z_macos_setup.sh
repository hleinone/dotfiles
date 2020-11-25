#!/bin/sh
set -o errexit -o nounset

REPOS_DIR="$(mktemp -d -t macos_setup_repos)"

trap 'rm -rf "$REPOS_DIR"' EXIT
(
    echo "Installing PAM Touch ID..."
    cd "$REPOS_DIR"
    set -x
    git clone https://github.com/Reflejo/pam-touchID.git
    cd pam-touchID
    sudo make install
    set +x

    cd -
    echo "Installing PAM Watch ID..."
    set -x
    git clone https://github.com/biscuitehh/pam-watchid.git
    cd pam-watchid
    sudo make install
    set +x
)

echo "Updating Dock..."

set -x
dockutil --remove all --no-restart
dockutil --add ~/Downloads --display stack # Implicitly restarts the Dock.
set +x

echo "Install Additional Tools for Xcode from: https://developer.apple.com/download/more/"
echo "Install Smart Scroll from: https://www.marcmoini.com/sx_en.html"
echo "Install Android Studio, AppCode etc. from Jetbrains Toolbox"
