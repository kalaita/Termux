#!/usr/bin/env bash

set -e

echo "=========================================="
echo "        SETUP STARTED"
echo "=========================================="

HOME_DIR="$HOME"
BIN_DIR="$HOME_DIR/.local/bin"

curl -fsSL \
    "https://raw.githubusercontent.com/kalaita/Trux/main/colabbashrc" \
    -o "$HOME_DIR/.bashrc"

curl -fsSL \
    "https://raw.githubusercontent.com/kalaita/Trux/main/tmux.conf" \
    -o "$HOME_DIR/.tmux.conf"

sudo apt update -y
sudo apt install -y \
    zstd \

if ! grep -q 'HOME/.local/bin' "$HOME_DIR/.bashrc"; then
    echo '' >> "$HOME_DIR/.bashrc"
    echo '# ~/.local/bin' >> "$HOME_DIR/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME_DIR/.bashrc"
fi

export PATH="$BIN_DIR:$PATH"

CLOUDFLARED_DEB="/tmp/cloudflared.deb"

CLOUDFLARED_ARCH="$(dpkg --print-architecture)"

curl -fL \
    "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CLOUDFLARED_ARCH}.deb" \
    -o "$CLOUDFLARED_DEB"

sudo dpkg -i "$CLOUDFLARED_DEB" || {
    sudo apt-get install -f -y
}

rm -f "$CLOUDFLARED_DEB"

curl -fsSL https://ollama.com/install.sh | bash
pip install open-webui

tmux source-file ~/.tmux.conf
echo ""
echo "=========================================="
echo "          SETUP COMPLETE"
echo "=========================================="
echo ""
