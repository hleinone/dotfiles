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

echo ""
echo "\033[0;32mInstall Additional Tools for Xcode from: https://developer.apple.com/download/more/\033[0m"
echo "\033[0;32mInstall Smart Scroll from: https://www.marcmoini.com/sx_en.html\033[0m"
echo "\033[0;32mInstall Android Studio, AppCode etc. from Jetbrains Toolbox\033[0m"
echo ""
echo "\033[0;32mTurn on VSCode settings sync\033[0m"
echo "\033[0;32mTurn on BetterTouchTool settings sync\033[0m"
echo "\033[0;32mTurn on Android Studio & AppCode settings sync\033[0m"
