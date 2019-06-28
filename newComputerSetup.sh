#!/bin/bash


NORM="\e[0m"
BOLD="\e[1m"
DIM="\e[2m"
RED="\e[31m"
GRN="\e[32m"

# https://github.com/why-jay/osx-init/blob/master/install.sh


# Unhide useful folders
# ----------------------------------------------------------------------
chflags nohidden ~/Library



# ----------------------------------------------------------------------
# 					Install brew package manager
# ----------------------------------------------------------------------

printf "\n\n"$BOLD"Setting up developer command line tools "$NORM"\n"

printf "Command line developer tools:\t\t"
if [[ $(xcode-select -p 1>/dev/null;echo $?) ]]
then
	printf ""$GRN"INSTALLED"$NORM"\n"
else
	printf ""$RED"MISSING"$NORM"\n"
	./installCLTools.sh
fi




# ----------------------------------------------------------------------
# 							now install Homebrew
# ----------------------------------------------------------------------

printf "\n\n"$BOLD"Setting up HomeBrew package manager "$NORM"\n"
printf "Homebrew package manager:\t\t"
if [ -x "$(command -v brew)" ]
then
	printf ""$GRN"INSTALLED"$NORM"\n"
else
	printf ""$RED"MISSING"$NORM"\n"
	printf "Installing Homebrew...\n"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi




# ----------------------------------------------------------------------
# 						Installing Brew GNU linux tools
# ----------------------------------------------------------------------

# brew install grep --with-default-names
# --with-default-names removed by https://github.com/Homebrew/homebrew-core/pull/35720
	brew install grep
	echo 'PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"' >> ~/.bash_profile

	brew install dialog


# ----------------------------------------------------------------------
# 				Installing useful OS X QuickView Extensions
# ----------------------------------------------------------------------

brew cask install qlstephen
brew cask install qlcolorcode
brew cask install qlcommonmark
brew cask install quicklook-csv
brew cask install quicklook-json



# ----------------------------------------------------------------------
# 					Bash profile - aliases, etc
# ----------------------------------------------------------------------
printf "\n\n"$BOLD"Setting up bash profile and aliases "$NORM"\n"

printf "USER\s .bash_profile file: \t\t"
if [[ -e "$HOME/.bash_profile" ]]
then
	printf "EXISTS\n"
	# Decide if we append, replace, or skip


else
	printf ""$RED"NOT FOUND"$NORM"\n"
	printf "Installing .bash_profile for user "$USER" \n"
	cp bash_profile "$HOME"/.bash_profile
fi




# ----------------------------------------------------------------------
# 					color vim and syntax highlighting
# ----------------------------------------------------------------------
printf "\n\n"$BOLD"Setting up vim syntax highlighting "$NORM"\n"

printf "USER\s .vimrc file: \t\t"
if [[ -e "$HOME/.vimrc" ]]
then
	printf "EXISTS\n"
	# Decide if we append, replace, or skip


else
	printf ""$RED"NOT FOUND"$NORM"\n"
	printf "Installing .vimrc for user "$USER" \n"
	cp vimrc "$HOME"/.vimrc
fi








# Install modern python environment
# ----------------------------------------------------------------------

brew install python2
brew install python3
pip2 install virtualenv
pip2 install virtualenvwrapper

pip2 install -U pip
pip3 install -U pip



# Load updated bash paths and aliases
source ~/.bash_profile



# ----------------------------------------------------------------------
# 					Set OS X Dock and Icon preferences
# ----------------------------------------------------------------------
printf "\n\n"$BOLD"Setting desktop environment preferences "$NORM"\n"
./setPreferences.sh

