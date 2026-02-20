#!/bin/bash

echo "Copying bash rc and alias..."
cp -rf .bashrc ~/
cp -rf .bash_aliases ~/

echo "running .."
source ~/.bashrc
source ~/.bash_aliases

echo "Done!"
