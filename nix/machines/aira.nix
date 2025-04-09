{ pkgs, config, nix-homebrew, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
  [
    pkgs.mkalias
    pkgs.neovim
    pkgs.nano
    pkgs.tmux
    pkgs.discord
  ];

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "google-chrome"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
      "Slack" = 803453959;
      "WhatsApp" = 310633997;
      "Wireguard" = 1451685025;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

      fonts.packages =
	[ pkgs.jetbrains-mono
	  pkgs.fira-code
	];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
 
  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
    name = "system-applications";
    paths = config.environment.systemPackages;
    pathsToLink = "/Applications";
  };
  in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
  system.defaults = {
    dock.autohide = true;
    dock.autohide-time-modifier = 0.5;
    dock.show-recents = false;
    dock.persistent-apps = [ 
      "/System/Applications/Launchpad.app"
      "/System/Applications/Utilities/Terminal.app"
      "/Applications/Google Chrome.app"				 
      "/System/Applications/Mail.app"
      "/System/Applications/Calendar.app"
      "/Applications/WhatsApp.app"
      "/Applications/Slack.app"
      "${pkgs.discord}/Applications/Discord.app"
      "/System/Applications/System Settings.app"
    ];
    dock.persistent-others = [ "/Users/edson/Downloads" ];
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
    controlcenter.BatteryShowPercentage = true;
  };
  nix-homebrew = {
      enable = true;
      # Apple Silicon
      enableRosetta = true;
      user = "edson";
  };
}
