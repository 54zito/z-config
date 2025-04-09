{
  description = "z-config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  {
    # Aira (darwin). Use 'nix run nix-darwin -- switch --flake .#aira' or 'darwin-rebuild switch --flake .#aira'
    darwinConfigurations."aira" = nix-darwin.lib.darwinSystem {
      modules = [
                  ./machines/aira.nix
                  nix-homebrew.darwinModules.nix-homebrew
                ];
    };
    
    # Piper (OS)
    # config for piper
  };
}
