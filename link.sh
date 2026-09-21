#!/usr/bin/env bash
# ~/dotfiles/link.sh
# Symlink all directories from ~/dotfiles to ~/.config,
# symlink .zshrc, and create an empty ~/.zsh_history.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

mkdir -p "$CONFIG_DIR"

echo "==> Installing dotfiles from: $DOTFILES_DIR"

link() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            echo "  [=] $dst (already exists)"
            return
        fi
        local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        echo "  [!] $dst exists - backing up to: $backup"
        mv "$dst" "$backup"
    fi

    ln -s "$src" "$dst"
    echo "  [+] $dst -> $src"
}

for dir in "$DOTFILES_DIR"/*/; do
    name="$(basename "$dir")"
    case "$name" in
        .git|.github) continue ;;
    esac
    link "${dir%/}" "$CONFIG_DIR/$name"
done

if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

    HISTORY_FILE="$HOME/.zsh_history"
    if [ -e "$HISTORY_FILE" ]; then
        echo "  [=] $HISTORY_FILE (already exists)"
    else
        touch "$HISTORY_FILE"
        chmod 600 "$HISTORY_FILE"
        echo "  [+] Created empty file: $HISTORY_FILE"
    fi
else
    echo "  [-] No $DOTFILES_DIR/.zshrc found - skipping"
fi

echo "==> Done."
