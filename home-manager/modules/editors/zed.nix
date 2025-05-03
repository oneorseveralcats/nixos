{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.zed;
in
{
  options.myHome.editors.zed = {
    enable = lib.mkEnableOption "Enable the zed text editor.";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };
  };
}
