#!/bin/bash

set -e

echo "🚀 Starting Ubuntu setup..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install basic dependencies
sudo apt install -y curl wget git unzip build-essential software-properties-common apt-transport-https

#######################################
# Install NVM and Node.js
#######################################
if [ ! -d "$HOME/.nvm" ]; then
  echo "📦 Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
  echo "✅ NVM already installed"
fi

echo "📦 Installing latest Node.js..."
nvm install --lts
nvm use --lts

#######################################
# Install VS Code
#######################################
echo "📦 Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code

#######################################
# Install Google Chrome
#######################################
echo "📦 Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

#######################################
# Install Warp terminal
#######################################
echo "📦 Installing Warp..."
wget wget https://releases.warp.dev/linux/warp-terminal_0.2025.09.24.08.11.stable.03_amd64.deb
sudo apt install -y ./warp-terminal_0.2025.09.24.08.11.stable.03_amd64.deb
rm warp-terminal_0.2025.09.24.08.11.stable.03_amd64.deb

#######################################
# Install Neovim + NvChad
#######################################
echo "📦 Installing Neovim..."
sudo apt install -y neovim

echo "📦 Setting up NvChad..."
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
else
  echo "✅ NvChad already installed"
fi

#######################################
# Install gh CLI
#######################################

sudo apt install gh

echo "📦 Installing global npm packages..."
npm install -g @executeautomation/playwright-mcp-server @nestjs/cli typescript ts-node pm2 nodemon autocannon @google/gemini-cli @angular/cli @nestjs/cli

echo "🎉 Setup complete! Please restart your terminal."

