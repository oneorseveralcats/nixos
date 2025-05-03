{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.yazi;
in
{
  options.myHome.file-managers.yazi = {
    enable = lib.mkEnableOption "Enable the yazi file manager.";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      settings = {
        sort_by = "natural";
        sort_dir_first = true;
        sort_sensitive = false;
        sort_translit = true;
      };
    };
  };
}
