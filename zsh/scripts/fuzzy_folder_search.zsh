#!/bin/zsh

target_dir=$(fd --type dir \
--hidden \
--max-depth 3 \
--base-directory ~ \
--search-path Desktop \
--search-path Downloads \
--exclude .git \
--exclude .github | fzf)

if [ -n "$target_dir" ]; then
    echo "From: $(pwd | sed "s|^$HOME|~|")"
    echo "  To: ~/${target_dir}"
    cd ~/"$target_dir"
fi
