{ pkgs, lib, config, ... }:

{
  CustomOptions = {
    modules = {
      fonts.enable = true;
    };
    user.homeDirectory =  "/Users/zito";
  };

  imports = [
    ./system.nix
  ];

  environment.systemPackages = with pkgs; [
    htop
    wget
    tmux
    neovim
    tree
    zoxide
    # # # # # # #
    google-chrome
    discord
    vscode
  ];

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    brews = [ "mas" ];
    casks = [  ];
    masApps = {
      "Bitwarden" = 1352778147;
      "Slack" = 803453959;
      "WhatsApp" = 310633997;
      "Wireguard" = 1451685025;
    };
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  networking = {
    hostName = "arya";
    localHostName = "arya";
    computerName = "Edson's MacBook Air";
  };

  system.stateVersion = 5;
  
  nixpkgs.hostPlatform = "aarch64-darwin";
}
