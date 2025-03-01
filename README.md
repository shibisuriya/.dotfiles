# .dotfiles

My dotfiles

# A note to myself

This is a public repo, make sure to not commit and push sensitive information to it. 
Make sure to clean up the commit history if you accidentally pushed sensitive information
to the remote.

## nix-darwin

1. Install nix for macOS. Do a multi user installation.

2. Clone the dotfiles repo, 

```bash
nix-shell -p git --run "git clone --recurse-submodules https://github.com/shibisuriya/.dotfiles ~/.dotfiles"
```

3. Install nix-darwin

```bash
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix-darwin#care_taker_1
```

4. The `darwin-rebuild` command

Ones nix-darwin is installed, we will have access to the `darwin-rebuild` command,

```bash
darwin-rebuild switch --flake ~/.dotfiles/nix-darwin#care_taker_1
```

5. Install TPM,

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Note: This step needs to be automated.  

6. Symlink your dotfiles to appropriate locations on your machine using GNU Stow, 

```bash
./stow.zsh # Uses GNU Stow under the hood.
```

I understand that 'nix home manager' can handle this more gracefully, but for now I am satisfied with Stow.

7. Update you git configuration (this step needs to be automated, I am performing this step manually for now because I don't want my email, etc. to leak).
