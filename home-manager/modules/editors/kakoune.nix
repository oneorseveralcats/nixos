{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.kakoune;
in
{
  options.myHome.editors.kakoune = {
    enable = lib.mkOption {
      description = "Enable the kakoune text editor (nvim).";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.kakoune = {
      enable = true;
    };
  };
}
