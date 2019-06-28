#/bin/bash

# 	This installation script will create standard directories
#	and populate them with MARS FCS scripts and links.
#

NORM="\e[0m"
BOLD="\e[1m"
DIM="\e[2m"

MARSDIR="MARS-scripts"
repoDir=$(dirname $(pwd))
instDir=$(pwd)
bashDir="$repoDir/bash"
binDir="$HOME/bin"


printf ""$BOLD"Installing MARS Scripts\n"$NORM""




#   ┌──────────────────────────────────────────────────┐
#   │        Add/Verify installation directory         │
#   └──────────────────────────────────────────────────┘

printf "Setting up user's script Directory\n"

if [ -d "$HOME/$MARSDIR" ]; then
	# Control will enter here if $MARSDIR exists.
	printf ""$DIM"MARS Directory already exists $NORM\n"
else
	printf "MARS Directory not found.\n"
	printf "Creating directory$BOLD $HOME/$MARSDIR $NORM\n"
	mkdir "$HOME/$MARSDIR"
fi

MARSDIR="$HOME/$MARSDIR"




#   ┌──────────────────────────────────────────────────┐
#   │            Add/Verify User Path ~/bin.           │
#   └──────────────────────────────────────────────────┘

printf "Setting up user path and $HOME/bin \n"

if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
  printf ""$DIM"User path is properly set $NORM\n"
else
  printf "Adding $BOLD$HOME/bin $NORMto the user path."
	if [[ $(uname) == "Darwin" ]]; then
		# In Mac OS X
		MACPATHDIR="/etc/paths.d"
		sudo touch $MACPATHDIR/MARS-scripts
		echo "$HOME/$bin" | sudo tee $MACPATHDIR/MARS-scripts
	else # Regular Linux flavors
		printf "Modifying $BOLD$HOME/.bash_profile $NORM\n"
		sed -i '/^export PATH/i PATH=$PATH:$HOME/bin' $HOME/.bash_profile
		PATH=$PATH:$HOME/bin
		export PATH
	fi
fi




#   ┌──────────────────────────────────────────────────┐
#   │         Copy scripts to target directory         │
#   └──────────────────────────────────────────────────┘

printf "Installing MARS bash scripts to user directory \n"

cd "$bashDir"

for f in *.sh
do
	if [[ -e $MARSDIR/$f ]]
	then
		printf "$DIM%-20s %-18s %s$NORM\n" $f "already exists in" "$MARSDIR"

		if ! cmp $f "$MARSDIR/$f" >/dev/null 2>&1 
		then
			# files are different
			printf "$DIM%-20s %-18s %s$NORM\n" $f "script updated in" "$MARSDIR"
			if [[ ! -d $MARSDIR/lastversion ]]
			then
				mkdir $MARSDIR/lastversion
			fi

			cp "$MARSDIR/$f" "$MARSDIR/lastversion/$f"
			cp $f $MARSDIR

		else
			# files are the same. Use : for a no-op
			:
		fi

	else
		printf "$NORM%-20s $DIM%-18s %s$NORM\n" $f "installed in" "$MARSDIR"
		# echo "Installing \t\t$BOLD$f$NORM"
		cp $f $MARSDIR
	fi
done




#   ┌──────────────────────────────────────────────────┐
#   │        Add/Setup symbolic links to ~/bin         │
#   └──────────────────────────────────────────────────┘

printf "Setting up links in $HOME/bin\n"

cd $bashDir

for f in *.sh
do
	cd $binDir

	simlink="$(basename $f .sh)"

	if [[ -h $simlink ]]; then
		printf ""$DIM"%-30s %-10s %-30s $NORM\n" "$binDir/$simlink" "exists in" "$MARSDIR/$f"
	else
		printf "%-30s "$DIM"%-10s "$NORM"%-30s \n" "$binDir/$simlink" "linked to" "$MARSDIR/$f"
		ln -s "$MARSDIR/$f" "$binDir/$simlink"
	fi

done




#   ┌──────────────────────────────────────────────────┐
#   │              Installation complete               │
#   └──────────────────────────────────────────────────┘

printf "\n\nInstallation of MARS-scripts is complete.\n"
printf "Scripts are located in $MARSDIR \n"
printf "Symbolic links made in $binDir \n"
printf "Path updated to include $binDir \n\n"
