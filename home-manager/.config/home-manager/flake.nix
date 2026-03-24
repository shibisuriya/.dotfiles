{
  description = "Minimal Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    username = "shibi";
    homeDirectory = "/home/shibi";
    pkgs = import nixpkgs {inherit system;};
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        {
          fonts.fontconfig.enable = true;

          home.username = username;
          home.homeDirectory = homeDirectory;

          home.stateVersion = "24.11";

          programs.home-manager.enable = true;

          # Pass pkgs inside the module explicitly
          home.packages = [
            pkgs.speedcrunch
            pkgs.nerd-fonts.jetbrains-mono
            pkgs.gimp-with-plugins
            pkgs.go
            # nix-darwin doesn't added Transmission GUI to mac's Launchpad, to
            # launch an instance of Transmission GUI use the command `transmission-qt`.
            pkgs.transmission_4-qt
            pkgs.parallel-full
            pkgs.httpie
            pkgs.maven
            pkgs.rustup
            pkgs.firefox-unwrapped
            pkgs.fzf
            pkgs.starship
            pkgs.gcc
            pkgs.fnm
            pkgs.python314
            pkgs.cowsay
            pkgs.htop
            pkgs.fd
            pkgs.stow
            pkgs.tmux
            pkgs.neovim
            pkgs.ripgrep
            pkgs.lf
            pkgs.git
            pkgs.pandoc
            pkgs.tree
            pkgs.flameshot
            pkgs.tor-browser
            pkgs.vlc
            pkgs.trash-cli
            pkgs.rsync
            # pkgs.docker-compose
            # pkgs.qemu
            # pkgs.zsh
            # pkgs.zsh-autosuggestions
            # pkgs.zsh-syntax-highlighting
            # pkgs.kitty
          ];
        }
      ];
    };
  };
}
