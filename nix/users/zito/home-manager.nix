{ pkgs, config, ... }:

{
  home-manager.useGlobalPkgs = false;
  home-manager.useUserPackages = true;
  home-manager.users.zito = {
    imports = [ ./git-config.nix ];
    programs.zsh = {
      enable = true;
      initExtra = builtins.readFile ../../../.config/.zshrc;
    };
    home.username = "zito";
    home.homeDirectory = config.CustomOptions.user.homeDirectory;
    home.stateVersion = "24.11";
  };
}
