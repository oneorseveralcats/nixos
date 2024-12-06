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
    home.sessionVariables = {
      TERMINAL = "footclient --title Terminal";
    };

    home.packages = with pkgs; [
      anki
      deluge
      gimp
      keepassxc
      mullvad-vpn
      nsxiv
      udiskie usbimager
      xournalpp

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
    home.file.".local/bin/w3m" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        export W3M_IMG2SIXEL="img2sixel -d atkinson"
        exec "${pkgs.w3m}/bin/w3m" -sixel "$@"
      '';
    };

    programs.zathura = {
      enable = true;
      options = {
        guioptions = "";
        selection-clipboard = "clipboard";
      };
      extraConfig = ''
        unmap [normal] 	   q
        unmap [fullscreen] q
        map [normal]     f     toggle_fullscreen
        map [fullscreen] f     toggle_fullscreen
        map [normal]     u     recolor
        map [fullscreen] u     recolor
        map [normal]     <C-f> follow
        map [fullscreen] <C-f> follow
        map [normal]     <C-q> quit
        map [fullscreen] <C-q> quit

        map [normal]     <Button8> navigate previous
        map [fullscreen] <Button8> navigate previous

        map [normal]     <Button9> navigate next
        map [fullscreen] <Button9> navigate next
      '';
    };

    programs.pqiv = {
      enable = true;
      settings = {
        options = {
          browse = true;
          hide-info-box = true;
          max-depth = 1;
          window-position = "1510,0";
        };
      };
      extraConfig = ''
        [actions]
        set_cursor_auto_hide(1)
        set_scale_mode_fit_px(400,500)
      '';
    };

    services.udiskie = {
      enable = true;
      notify = false;
    };

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita-dark";
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        # package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };

    xresources = with config.home.sessionVariables; {
      properties = {
        "Nsxiv.window.background" =	"#${black}";
        "Nsxiv.window.foreground" =	"#${blue}";
        "Nsxiv.bar.font" = "monospace:style=light:size=14";
      };
    };
  };
}
