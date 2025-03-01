#!/bin/zsh

# Store the current directory
original_dir=$(pwd)

# Change to the home directory
cd ~ || { echo "Failed to change to home directory"; exit 1; }

# Define excluded directories
excluded_directories=(
    "node_modules"
    ".git"
    ".svn"
    ".vscode"
    "venv"
    "__pycache__"
    ".sass-cache"
    ".hg"
    ".bzr"
    ".idea"
    ".tox"
    ".gradle"
    ".settings"
    ".classpath"
    ".project"
    ".metadata"
    ".DS_Store"
    "__MACOSX"
    "Thumbs.db"
    ".Spotlight-V100"
    ".Trashes"
    ".fseventsd"
)

# Prepare the find command excluding directories
find_command="find . -maxdepth 4 "
for dir in "${excluded_directories[@]}"; do
    find_command+=" -name '$dir' -prune -o "
done
find_command+=" -type d -print | fzf"

# Execute the find command and change directory if selected
selected_dir=$(eval "$find_command" </dev/tty)
if [ -n "$selected_dir" ]; then
    echo "Selected directory: $selected_dir"
    cd "$selected_dir" || { echo "Failed to change directory"; exit 1; }
    echo "Current directory: $(pwd)"
else
    echo "No directory selected. Returning to original directory."
    cd "$original_dir" || { echo "Failed to change back to original directory"; exit 1; }
fi
