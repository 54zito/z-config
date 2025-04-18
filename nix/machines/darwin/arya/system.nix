{ pkgs, lib, config, ... }:

{
  system.defaults = {
    dock = {
      orientation = "bottom";
      tilesize = 64;
      autohide = true;
      autohide-time-modifier = 0.5;
      show-recents = false;
      minimize-to-application = true;
      magnification = false;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/System/Applications/Utilities/Terminal.app"
        "${pkgs.google-chrome}/Applications/Google Chrome.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/WhatsApp.app"
        "/Applications/Slack.app"
        "${pkgs.discord}/Applications/Discord.app"
        "/Applications/Bitwarden.app"
        "/System/Applications/System Settings.app"
      ];
      persistent-others = [
        "/Users/zito/Downloads"
      ];
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
    };

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
      NewWindowTarget = "Home";
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowExternalHardDrivesOnDesktop = true;
      ShowStatusBar = true;
      ShowPathbar = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 20;
      AppleICUForce24HourTime = true;
    };

    controlcenter.BatteryShowPercentage = true;

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "Setting up Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
}