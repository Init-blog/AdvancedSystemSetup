#!/bin/bash

# Install fonts
# Copy included fonts to the Fonts directory
cp -rf SysSettings/fonts/* ~/Library/Fonts 

# ZSH configuration:
# Restore my custom zsh4humans and powerlevel10k configurations
# Create own custom configuration following instructions here:
# https://github.com/romkatv/zsh4humans
cp -rf SysSettings/Terminal/zsh/.* ~/
source ~/.zshrc > /dev/null 2>&1

# Instal Nord theme for the terminal and set it as default
sh SysSettings/Terminal/theme/terminalTheme.sh


# Set system settings
defaults write com.apple.dock "tilesize" -int 48                # Sets the tile size of the dock to 48 pixels
defaults write com.apple.dock largesize -int 96                 # Sets the size of magnified icons in the dock to 96 pixels
defaults write com.apple.dock scroll-to-open -bool TRUE         # Enables scroll-to-open for dock icons
defaults write com.apple.dock springboard-columns -int 8        # Sets the number of columns in the dock to 8
defaults write com.apple.dock springboard-rows -int 6           # Sets the number of rows in the dock to 6
defaults write com.apple.dock show-recents -bool false          # Hides recent applications in the dock
defaults write com.apple.screencapture location ~/Downloads     # Sets it as default location for screenshots
defaults write com.apple.dashboard mcx-disabled -boolean YES    # Disables the Dashboard

# Restart the dock for changes to take effect
killall Dock

# Enable safari dev menus
# Enables the develop menu in Safari
sudo defaults write com.apple.Safari IncludeDevelopMenu -bool true
