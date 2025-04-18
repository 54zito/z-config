{ pkgs, lib, config, ... }:

{
  options = {
    CustomOptions.user.homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/zito";
      description = "Path to home directory used in (users.users.yourUsername.home) and (home-manager.users.yourUsername.home.homeDirectory)";
    };
  };
  config = {
    users.users.zito = {
      name = "zito";
      home = config.CustomOptions.user.homeDirectory;
    };
  };
  imports = [ ./home-manager.nix ];
}
