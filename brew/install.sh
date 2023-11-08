#!/bin/bash

# Install Homebrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" < /dev/null

# Enable the brew command
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install packages using the Brewfile
brew bundle --file=./brew/Brewfile

# When installing any software from the internet
# Apple will warn you about it being unsafe teh first time you open it
# Add to the list below all the apps you want to declare as safe to skip the warnings
apps=(    
    "/Applications/Visual Studio Code.app"
    "/Applications/Microsoft Edge.app"
    "/Applications/GitHub Desktop.app"
    "/Applications/Google Chrome.app"    
    "/Applications/QR Capture.app"
    "/Applications/CopyClip.app"
    "/Applications/Docker.app"
    "/Applications/Magnet.app"
    "/Applications/Figma.app"
    "/Applications/Miro.app"
    # "/Applications/WhatsApp.app"
    # "/Applications/zoom.us.app"
)


# for app in "${apps[@]}"; do    
#     # Remove the com.apple.quarantine attribute    
#     sudo xattr -dr com.apple.quarantine "$app"
# done
