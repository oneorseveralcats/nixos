{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.joshuto;
in
{
  options.myHome.file-managers.joshuto = {
    enable = lib.mkEnableOption "Enable the joshuto file manager.";
  };

  config = mkIf cfg.enable {
    myHome.file-managers.pistol.enable = true;

    programs.joshuto = {
      enable = true;
      settings = {
        xdg_open = true;
        xdg_open_fork = true;

      
        display = {
        };

        preview = {
          preview_protocol = "sixel";
          max_preview_size = "10GB";
          preview_script = "${pkgs.pistol}/bin/pistol";
        };
      };
      keymap = {};
    };
  };
}



