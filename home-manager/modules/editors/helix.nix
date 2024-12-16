{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.helix;
in
{
  options.myHome.editors.helix = {
    enable = lib.mkOption {
      description = "Enable the helix text editor (hx).";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
  };
}
