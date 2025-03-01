# Enable vi mode
bindkey -v

# Check if the system is macOS
is_mac=false
if [[ "$(uname)" == "Darwin" ]]; then
    is_mac=true
fi

if $is_mac; then
    export PATH="/opt/homebrew/bin:$PATH" # for homebrew.
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    HOME_DIR="Users/$(whoami)"
    if [[ ! "$PATH" == */${HOME_DIR}/.fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/${HOME_DIR}/.fzf/bin"
    fi
else
    HOME_DIR="$(whoami)"
    if [[ ! "$PATH" == */${HOME_DIR}/.fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/${HOME_DIR}/.fzf/bin"
    fi

    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

source <(fzf --zsh)


# For nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH=$PATH:/usr/local/go/bin # lf file manager needs golang.
export PATH=$PATH:~/go/bin # globally installed go packages are stored here.


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/shibisuriya/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(starship init zsh)"

# aliases
alias vim='nvim'
alias vi="nvim"
alias v="nvim ."
alias c="code ."
alias o="open ."
alias lf="lfcd"

lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}


# utils
alias fs=". ~/scripts/fuzzy_folder_search.zsh"
alias lazy-jenkins='node ./src/index.js'
alias node-scrub="~/scripts/node_scrub.zsh"

# In normal mode, press <ctrl> + e to edit the command written so far edit in neovim.
export VISUAL=nvim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line

yt-snip() {

      # Create a directory named yt-snips in the shell's current working directory
      # and bind mount it into the Docker container. The program running inside the
      # container will save the trimmed video to the yt-snips directory.

      if [ ! -d './yt-snips' ]; then
        mkdir './yt-snips'
      else
        # If the directory already exists, bind mount it as is, including any files it may
        # contain. This ensures the container can only access the yt-snips folder and
        # nothing else on your host machine.
        echo "The 'yt-snips' directory already exists."
        echo "The 'yt-snips' directory may contain confidential files that you might not want to share with the container."
        echo "Do you wish to share it with the container? (y/n)"
        read -r response
        if [[ $response == "y" ]]; then
            echo "You chose to share the 'yt-snips' directory with the container."
            # Add the code to bind mount the directory here
        else
            echo "You chose not to share the 'yt-snips' directory with the container."
            echo "exiting!"
            return
        fi
      fi

      docker-compose -f ~/scripts/yt-snip/docker-compose.yml run --rm yt-snip "$@"
}

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="$PATH:/usr/local/texlive/2018/bin/x86_64-darwin"

# bun completions
[ -s "/Users/shibisuriya/.bun/_bun" ] && source "/Users/shibisuriya/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
