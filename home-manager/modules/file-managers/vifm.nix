{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.vifm;
in
{
  options.myHome.file-managers.vifm = {
    enable = lib.mkOption {
      description = "Enable the vifm file manager.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    myHome.file-managers.pistol.enable = true;

    programs.vifm = {
      enable = true;
    };
  };
}


