#!/bin/bash

# Install the theme
# Open Nord terminal
open -a Terminal.app SysSettings/Terminal/theme/Nord.terminal
# Wait for the theme to install
sleep 2

# Set the theme as the default
defaults write com.apple.terminal "Default Window Settings" -string "Nord"
defaults write com.apple.terminal "Startup Window Settings" -string "Nord"
