{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.pandoc;
in
{
  options.myHome.cli.pandoc = {
    enable = lib.mkOption {
      description = "Enable the pandoc document converter.";
      type = types.bool;
      default = false;
    };
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

