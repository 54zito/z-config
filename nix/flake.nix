{
  description = "z-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-darwin-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager-darwin = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = { ... }@inputs:
  {
    # 'nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#arya'
    # 'darwin-rebuild switch --flake .#arya'
    darwinConfigurations."arya" = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./machines/darwin
        ./machines/darwin/arya
        ./modules
        ./users/zito
        inputs.home-manager-darwin.darwinModules.home-manager
      ];
    };
  };
}
