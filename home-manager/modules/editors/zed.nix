{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.zed;
in
{
  options.myHome.editors.zed = {
    enable = lib.mkOption {
      description = "Enable the kakoune text editor (nvim).";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };
  };
}
