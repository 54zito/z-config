{ pkgs, lib, config, ... }:

let
  customFonts = pkgs.stdenv.mkDerivation {
    name = "custom fonts";
    src = ../../../fonts;

    installPhase = ''
      mkdir -p $out/share/fonts
      cp -r * $out/share/fonts/
    '';
  };
in
{
  options = {
    CustomOptions.modules.fonts.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable fonts module";
    };
  };
  config = lib.mkIf config.CustomOptions.modules.fonts.enable {
    fonts.packages = [ customFonts ];
  };
}
