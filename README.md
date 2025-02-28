# .dotfiles-new
My new dotfiles


## nix-darwin

1. Install nix

2. Clone the dotfiles repo, 

```bash
nix-shell -p git --run "git clone https://github.com/shibisuriya/.dotfiles-new ~/.dotfiles"
```

3. Install nix-darwin

```bash
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix-darwin#care_taker_1
```


