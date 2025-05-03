{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.kakoune;
in
{
  options.myHome.editors.kakoune = {
    enable = lib.mkEnableOption "Enable the kakoune text editor.";
  };

  config = mkIf cfg.enable {
    programs.kakoune = {
      enable = true;
    };
  };
}
