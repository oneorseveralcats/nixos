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

    programs.pandoc = {
      enable = true;
      defaults = {
        pdf-engine = "typst";
      };
    };
  };
}

