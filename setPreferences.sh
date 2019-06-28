#!/bin/bash

defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
defaults write com.apple.dock persistent-apps -array; # remove icons in Dock
# defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
defaults write com.apple.dock autohide -bool true; # turn Dock auto-hidng on
defaults write com.apple.dock autohide-delay -float 0; # remove Dock show delay
defaults write com.apple.dock autohide-time-modifier -float 0; # remove Dock show delay
defaults write com.apple.dock orientation right; # place Dock on the right side of screen



killall dock 2>/dev/null;
killall Finder 2>/dev/null;

