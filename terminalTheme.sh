#/bin/bash

# Set terminal default theme


theme=$(<terminalTheme.xml)
plutil -replace Window\ Settings.Material-Theme -xml "$theme" ~/Library/Preferences/com.apple.Terminal.plist
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

