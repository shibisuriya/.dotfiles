## home-manager (Ubuntu PC)

Run this command after cloning your dotfiles repo.

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"; nix run github:nix-community/home-manager --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/home-manager/.config/home-manager/
```

The `home-manager` command will be available if the command
written above executes successfully atleast ones.

```bash
home-manager switch
```

## Change your default shell from bash to zsh,

```bash
command -v zsh | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)"
```

## Symlink all of your dotfiles to their target location

```bash
./stow.zsh
```

TODO: Transfer the content of this readme to your blog post.
