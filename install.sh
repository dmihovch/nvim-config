#!/usr/bin/env bash
# =============================================================================
# Neovim Config Bootstrap — Debian / Ubuntu
# =============================================================================
# Installs everything needed for this Neovim config on a fresh system.
#
# Usage:
#   chmod +x install.sh && ./install.sh
# =============================================================================

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

# ---- Ensure we're on Debian/Ubuntu ----
if ! command -v apt-get &>/dev/null; then
    err "This script only supports Debian / Ubuntu (apt-get not found)."
    exit 1
fi

echo ""
echo "============================================"
echo "  Neovim Config Bootstrap — Debian/Ubuntu"
echo "============================================"
echo ""

# ---- 1. System packages ----
info "Updating package lists..."
sudo apt-get update -qq

info "Installing system dependencies..."
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

# fd is named fdfind on Debian — create an alias if needed
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    mkdir -p ~/.local/bin
    ln -sf "$(command -v fdfind)" ~/.local/bin/fd
    ok "Created ~/.local/bin/fd → fdfind symlink"
fi

ok "System packages installed."

# ---- 2. Neovim (from official repo for latest version) ----
if command -v nvim &>/dev/null; then
    ok "Neovim already installed: $(nvim --version | head -1)"
else
    info "Installing Neovim..."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update -qq
    sudo apt-get install -y -qq neovim
    ok "Neovim installed: $(nvim --version | head -1)"
fi

# ---- 3. Optional: lazygit (magit-like git interface) ----
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

# ---- 4. Bootstrap Neovim plugins ----
info "Installing Neovim plugins (this may take a minute)..."
nvim --headless "+Lazy! sync" +qa 2>&1 || warn "Plugin install had warnings (this is often OK)."
ok "Plugins installed."

# ---- 5. Health check ----
info "Running :checkhealth..."
nvim --headless "+checkhealth" +qa 2>&1 | head -50

echo ""
echo "============================================"
echo "  Done. Open Neovim and start coding."
echo "============================================"
echo ""
echo "Quick reference:"
echo "  <Space>ff  →  Find files"
echo "  <Space>fg  →  Live grep"
echo "  <Space>fb  →  Switch buffers"
echo "  <Space>e   →  File explorer (oil.nvim)"
echo "  <Space>tt  →  Terminal"
echo "  <Space>cc  →  Compile"
echo "  <Space>xx  →  Diagnostics"
echo ""
echo "Full docs: ~/.config/nvim/README.md"
echo ""