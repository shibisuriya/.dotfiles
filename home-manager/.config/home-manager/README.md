## home manager

```bash
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager
```
If you run this command you the 'home-manager' command will become available.

```bash
home-manager switch
```

If you don't mention the path in the command above, home-manager will look for the flake.nix
file in `~/.config/home-manager`.

