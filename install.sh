#!/usr/bin/env bash
# Neovim config bootstrap for Debian / Ubuntu.
#
# Usage:
#   chmod +x install.sh && ./install.sh

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
err()   { echo -e "${RED}[ERROR]${NC} $*"; }

if ! command -v apt-get &>/dev/null; then
    err "apt-get not found. This script supports Debian / Ubuntu."
    exit 1
fi

echo ""
echo "============================================"
echo "  Neovim Config Bootstrap"
echo "============================================"
echo ""

# System packages.
info "Updating package lists..."
sudo apt-get update -qq

info "Installing dependencies..."
sudo apt-get install -y -qq \
    git \
    make \
    gcc \
    unzip \
    ripgrep \
    fd-find \
    python3 \
    python3-pip \
    nodejs \
    npm \
    golang-go

# fd is named fdfind on Debian.
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    mkdir -p ~/.local/bin
    ln -sf "$(command -v fdfind)" ~/.local/bin/fd
    ok "Created ~/.local/bin/fd symlink"
fi

ok "System packages installed."

# Neovim from PPA.
if command -v nvim &>/dev/null; then
    ok "Neovim already installed: $(nvim --version | head -1)"
else
    info "Installing Neovim..."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update -qq
    sudo apt-get install -y -qq neovim
    ok "Neovim installed: $(nvim --version | head -1)"
fi

# lazygit.
if command -v lazygit &>/dev/null; then
    ok "lazygit already installed."
else
    info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit /tmp/lazygit.tar.gz
    ok "lazygit installed."
fi

# Neovim plugins.
info "Installing plugins..."
nvim --headless "+Lazy! sync" +qa 2>&1 || warn "Plugin install warnings (often OK)."
ok "Plugins installed."

# Health check.
info "Running :checkhealth..."
nvim --headless "+checkhealth" +qa 2>&1 | head -50

echo ""
echo "============================================"
echo "  Done."
echo "============================================"
echo ""
echo "Keys:"
echo "  <Space>ff  Find files"
echo "  <Space>fg  Live grep"
echo "  <Space>fb  Switch buffers"
echo "  <Space>e   File explorer"
echo "  <Space>tt  Terminal"
echo "  <Space>cc  Compile"
echo "  <Space>xx  Diagnostics"
echo ""
echo "Docs: ~/.config/nvim/README.md"
echo ""