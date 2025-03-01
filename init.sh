#!/bin/zsh

if [[ "$(uname)" == "Darwin" ]]; then
  vscode_settings_dir="$HOME/Library/Application Support/Code/User"
else
  vscode_settings_dir="$HOME/.config/Code/User"
fi

stow -t "$HOME" git zsh lf alacritty kitty rg nvim zellij
stow -t "$vscode_settings_dir" vscode

