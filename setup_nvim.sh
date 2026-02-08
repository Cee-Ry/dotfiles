#!/bin/bash

echo "Installing Neovim and dependencies..."
sudo dnf install neovim python3-neovim ripgrep fd-find git -y

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Setting up Neovim config..."
mkdir -p ~/.config/nvim
[ -f ~/dotfiles/.config/nvim/init.vim ] && cp ~/dotfiles/.config/nvim/init.vim ~/.config/nvim
[ -f ~/dotfiles/.config/nvim/coc-settings.json ] && cp ~/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim

echo "Installing plugins..."
nvim --headless +PlugInstall +qall
nvim --headless +CocInstall coc-clangd coc-python coc-json coc-html coc-tsserver coc-cmake +qall

echo "Installing C development tools..."
sudo dnf group install "C Development Tools and Libraries" -y
sudo dnf install clang clang-tools-extra -y

echo "All done! 🎉"
