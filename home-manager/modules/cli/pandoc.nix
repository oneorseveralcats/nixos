{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.pandoc;
in
{
  options.myHome.cli.pandoc = {
    enable = lib.mkEnableOption "Enable the pandoc document converter.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      typst
    ];

    home = {
      sessionVariables = {
        TYPST_FONT_PATHS="${config.home.homeDirectory}/.nix-profile/share/fonts";
      };
    };

    programs.pandoc = {
      enable = true;
      defaults = {
        pdf-engine = "typst";
      };
    };
  };
}

