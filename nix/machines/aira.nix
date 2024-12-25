{ pkgs, ...}:
{
  # Allow nix to install software with unfree license
  nixpkgs.config.allowUnfree = true;

  # Packages
  environment.systemPackages =[
    pkgs.nano
    pkgs.tmux
    pkgs.discord
  ];

  # Fonts
  fonts.packages =[
    pkgs.jetbrains-mono
    pkgs.fira-code
  ];

  # Macbook system settings
  system.defaults ={
	  dock.autohide = true;
	  dock.autohide-time-modifier = 0.5;
	  dock.show-recents = false;
	  dock.persistent-apps =[
      "/System/Applications/Launchpad.app"
      "/Applications/Google Chrome.app"				 
      "/System/Applications/Mail.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Notes.app"
      "/Applications/WhatsApp.app"
      "/Applications/Slack.app"
      "${pkgs.discord}/Applications/Discord.app"
      "/System/Applications/System Settings.app"
    ];
    dock.persistent-others =[
      "/Users/zito/Downloads"
    ];
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
    controlcenter.BatteryShowPercentage = true;
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
