#!/bin/zsh

unstow=false
for arg in "$@"; do
  if [[ "$arg" == "-D" ]]; then
    unstow=true
  fi
done

stow_unstow_package() {
  local package_name=$1
  local target=$2

  if [[ "$unstow" == true ]]; then
    echo "Unstowing package: $package_name"
    stow -t "$target" -D "$package_name"
  else
    echo "Stowing package: $package_name"
    stow -t "$target" "$package_name"
  fi
}


packages=()

if [[ "$(uname)" == "Darwin" ]]; then
  # For macOS
  packages=("aerospace" "alacritty" "git" "kitty" "lf" "nvim" "obsidian" "rg" "tmux" "zsh")
  vscode_settings_dir="$HOME/Library/Application Support/Code/User"

else
  # For Linux
  packages=("alacritty" "git" "kitty" "lf" "nvim" "obsidian" "rg" "tmux" "zsh")
  vscode_settings_dir="$HOME/.config/Code/User"
fi


if [ -d "$vscode_settings_dir" ]; then
    stow_unstow_package "vscode" "$vscode_settings_dir"
fi

for package in "${packages[@]}"; do
  stow_unstow_package "$package" "$HOME"
done

