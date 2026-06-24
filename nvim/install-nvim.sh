#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=> Fetching latest Neovim stable release..."

# 1. Download the latest stable Linux binary
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

echo "=> Extracting Neovim..."

# 2. Clean out any old manual installation in /opt/nvim
sudo rm -rf /opt/nvim

# 3. Extract to /opt/nvim
sudo mkdir -p /opt/nvim
sudo tar -C /opt/nvim --strip-components=1 -xzf nvim-linux-x86_64.tar.gz

echo "=> Creating symlinks..."

# 4. Expose the binary to your PATH globally via /usr/local/bin
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# 5. Clean up downloaded tarball
rm nvim-linux-x86_64.tar.gz

echo "=> Neovim installation complete!"
echo "=> Version installed:"
nvim --version | head -n 1
