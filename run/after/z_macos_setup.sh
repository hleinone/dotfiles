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

# Custom keyboard shortcuts
defaults write com.apple.universalaccess com.apple.custommenu.apps '(
"com.tinyspeck.slackmacgap", 
"com.apple.iphonesimulator", 
"com.apple.finder"
)'

defaults write com.apple.finder NSUserKeyEquivalents '{
Back="@\U2190";
Forward="@\U2192";
}'

defaults write com.apple.iphonesimulator NSUserKeyEquivalents '{
"Slow Animations"="@t";
}'

defaults write com.tinyspeck.slackmacgap NSUserKeyEquivalents '{
Back="@\U2190";
Forward="@\U2192";
}'

echo ""
echo "\e[32mInstall Additional Tools for Xcode from: https://developer.apple.com/download/more/"
echo "\e[32mInstall Smart Scroll from: https://www.marcmoini.com/sx_en.html"
echo "\e[32mInstall Android Studio, AppCode etc. from Jetbrains Toolbox"
echo ""
echo "\e[32mTurn on VSCode settings sync"
echo "\e[32mTurn on BetterTouchTool settings sync"
echo "\e[32mTurn on Android Studio & AppCode settings sync"
