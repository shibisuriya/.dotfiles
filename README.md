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
nix-shell -p git --run "git clone https://github.com/shibisuriya/.dotfiles ~/.dotfiles"
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
