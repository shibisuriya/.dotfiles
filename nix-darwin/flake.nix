{
  description = "Shibi's nix-darwin system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    /*
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs /*, home-manager */ }:
    let
     configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.rustup
            pkgs.zsh-autosuggestions
            pkgs.firefox-unwrapped
            pkgs.fzf
            pkgs.starship
            pkgs.libgccjit
            pkgs.fnm
            pkgs.python314
            pkgs.cowsay
            pkgs.htop
            pkgs.qemu
            pkgs.fd
            pkgs.stow
            pkgs.tmux
            # pkgs.neovim # The 'vim-tmux-navigator' plugin doesn't work when I install neovim using nix-darwin, I have installed neovim using brew.
            pkgs.ripgrep
            pkgs.lf
            pkgs.alacritty
            pkgs.git
            pkgs.kitty
            pkgs.aerospace
            pkgs.pandoc
            pkgs.tree
          ];


        system.primaryUser = "shibi";

        system.defaults = {
          dock.autohide = true;
          dock.expose-group-apps = true;
          finder = {
            AppleShowAllFiles = true;
            AppleShowAllExtensions = true;
          };
        };

        homebrew.enable = true;
        homebrew.brews = [
	      "neovim"
        ];


        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        # I haven't tested this, test it on a freshly
        # installed macOS...
        # - [x] Works when CLT is already present.
        # - [ ] Build when CLT is not installed.
        system.activationScripts.ensureCLT.text = ''
          if ! xcode-select -p &>/dev/null; then
            echo "Xcode Command Line Tools not installed. Run: xcode-select --install"
            exit 1
          fi
        '';
      };
    in
    {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."shibi" = nix-darwin.lib.darwinSystem {
        modules = [ 
          configuration
          /*
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              users.users.shibi.home = "/Users/shibi";
              home-manager.users.shibi = import ./home.nix;
            }
          */
        ];
      };
    };
}
