{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.ranger;
in
{
  options.myHome.file-managers.ranger = {
    enable = lib.mkEnableOption "Enable the ranger file manager.";
  };

  config = mkIf cfg.enable {
    myHome.file-managers.pistol.enable = true;

    programs.ranger = {
      enable = true;
    };
  };
}

