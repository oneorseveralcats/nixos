{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.ripgrep;
in
{
  options.myHome.cli.ripgrep = {
    enable = lib.mkEnableOption "ripgrep.";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
    };

    programs.ripgrep-all = {
      enable = true;
    };
  };
}
