{
  description = "safe-move";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux"; # or aarch64-darwin etc
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.mycli = pkgs.buildGoModule {
      pname = "mycli";
      version = "0.1.0";

      src = ./.;

      vendorHash = null; # run once, then fill this
    };

    # Optional dev shell
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [pkgs.go];
    };
  };
}
