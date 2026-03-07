#!/bin/bash

echo "Installing curl..."
sudo apt install curl

echo "add brave essentials..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "add brave essentials..."
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

echo "update"
sudo apt update

echo "Installing brave..."
sudo apt install brave-browser

echo "Done!"
