#!/bin/bash

echo "Starting..."

# Make the setup_nvim.sh script executable
chmod +x ~/dotfiles/setup_nvim.sh

# Run the setup_nvim.sh script
~/dotfiles/setup_nvim.sh

echo "Setting bashrc and alias"

# Copy bashrc and bash_aliases to home
cp -f ~/dotfiles/.bashrc ~/                 # Make sure the file is named .bashrc
cp -f ~/dotfiles/.bash_aliases ~/

# Reload the bash configuration
source ~/.bashrc
source ~/.bash_aliases

echo "NeoVim is done... replacing/adding .config files and cosmic setting"

# Copy all .config files, including cosmic, into the user's config folder
cp -rf ~/dotfiles/.config/* ~/.config/
