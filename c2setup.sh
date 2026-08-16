#!/usr/bin/env bash

set -e

echo "=========================================="
echo "        SETUP STARTED"
echo "=========================================="

HOME_DIR="$HOME"

touch "$HOME_DIR/.hushlogin"

curl -fsSL \
    "https://raw.githubusercontent.com/kalaita/Termux/main/c2bashrc" \
    -o "$HOME_DIR/.bashrc"

pip install google-colab-cli



echo ""
echo "=========================================="
echo "          SETUP COMPLETE"
echo "=========================================="
echo ""
