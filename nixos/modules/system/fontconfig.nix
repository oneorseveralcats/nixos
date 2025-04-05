{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.fontconfig;
in
{
  options.myConfig.system.fontconfig = {
    enable = mkEnableOption "Enable fontconfig configurations.";
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        corefonts
        fira-code-nerdfont
        noto-fonts
        noto-fonts-cjk-sans
        twemoji-color-font
      ];
      fontDir.enable = true;
      enableDefaultPackages = true;
      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif Light" "Noto Serif" ];
          sansSerif = [ "Noto Sans Light" "Noto Sans" ];
          monospace = [ "Fira Code Nerd Font Light" "Fira Code Light" "Noto Sans Mono" ];
          emoji = [ "Twitter Color Emoji" ];
        };
      };
    };
  };
}


