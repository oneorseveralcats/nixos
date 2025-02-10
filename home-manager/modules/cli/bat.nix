{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.bat;
in
{
  options.myHome.cli.bat = {
    enable = lib.mkOption {
      description = "Enable the bat pager.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      MANPAGER = "${pkgs.bat}/bin/bat -p";
    };

    programs.bat = {
      enable = true;
      config = {
      };
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
  };
}

