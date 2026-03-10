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
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting kitty -y
chsh -s "$(command -v zsh)"
```

## Symlink all of your dotfiles to their target location

```bash
./stow.zsh
```

## Install TPM (Tmux Package Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install i3wm

The option to use i3wm is not listed in the login screen
when i3 is installed using home-manager, so I am installing
it using apt.

```bash
sudo apt update
sudo apt install i3
```

## Install docker using `apt`

```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

TODO: Transfer the content of this readme to your blog post.
