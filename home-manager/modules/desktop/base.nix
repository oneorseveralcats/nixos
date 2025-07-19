{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.base;
in
{
  options.myHome.desktop.base = {
    enable = lib.mkOption {
      description = "Enable all the standard desktop packages and settings.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    myHome.media.zathura.enable = true;

    home.packages = with pkgs; [
      anki
      deluge
      gimp3-with-plugins
      keepassxc
      nb
      nsxiv
      udiskie usbimager
      xournalpp

      dconf
      hicolor-icon-theme
      adwaita-icon-theme gnome-themes-extra
    ] ++
      (if pkgs.system == "aarch64-linux" then
        [ pkgs.box64 pkgs.box86 ]
      else
        [])
    ;

    home.file.".XCompose".text = ''
      include "%L"
      <Multi_key> <l> <l> : "λ"
    '';

    services.udiskie = {
      enable = true;
      notify = true;
    };
  };
}
