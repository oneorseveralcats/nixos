{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.launchers.fuzzel;
in
{
  options.myHome.desktop.launchers.fuzzel = {
    enable = lib.mkEnableOption "and configure the fuzzel application launcher.";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/foot";
          list-executables-in-path = true;
        };
      };
    };

    myHome.stylix.enable = true;
    programs.fuzzel.settings = {
      # seems fixed upstream
      # main.icon-theme = "${config.stylix.iconTheme.dark}";
      colors = rec {
        match = lib.mkForce "${config.lib.stylix.colors.base0D-hex}ff";
        selection-match = match;
      };
    };
  };
}
