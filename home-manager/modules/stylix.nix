{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.stylix;
  stylix = import <stylix>;
in
{
  imports = [ stylix.homeModules.stylix ];

  options.myHome.stylix = {
    enable = lib.mkEnableOption "Enable stylix, a project to uniformly style NixOS.";
    styleDesktopApps = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "style desktop apps and toolkits like Qt & GTK.";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      image = "${pkgs.nixos-artwork.wallpapers.binary-black}/share/backgrounds/nixos/nix-wallpaper-binary-black.png";
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";
      base16Scheme = {
        name = "dark and vibrant";
        base00 = "#000000";
        base01 = "#202020";
        base02 = "#404040";
        base03 = "#606060";
        base04 = "#b0b0b0";
        base05 = "#d0d0d0";
        base06 = "#e0e0e0";
        base07 = "#ffffff";
        # base08 = "#f5708a";
        base08 = "#ee2244";
        base09 = "#ee8122";
        base0A = "#b8a300";
        base0B = "#54bc5c";
        base0C = "#00bab3";
        base0D = "#00aff2";
        base0E = "#9095ff";
        base0F = "#d47ada";
      };
      
      cursor = {
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
        size = 36;
      };

      icons = {
        enable = pkgs.stdenv.hostPlatform.isLinux && cfg.styleDesktopApps;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };

      fonts = rec {
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans Light";
        };
        serif = sansSerif;
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font Light";
        };
        emoji = {
          package = pkgs.twemoji-color-font;
          name = "Twitter Color Emoji";
        };

        sizes = {
          applications = 12;
          desktop = 16;
          popups = 14;
          terminal = 16;
        };
      };

      targets = {
        gtk.enable = cfg.styleDesktopApps;
        qt.enable = cfg.styleDesktopApps;

        waybar.addCss = false;
        avizo.enable = false;

        gtk.extraCss = /* css */ ''
          window.background { border-radius: 0; }
        '';
        swaylock = {
          enable = true; # fixed when system.stateVersion >= 23.05
          useWallpaper = false;
        };

        firefox.profileNames = [ "personal" "school" "offline" ];
        floorp.profileNames = config.stylix.targets.firefox.profileNames;
        librewolf.profileNames = config.stylix.targets.firefox.profileNames;
      };
    };
  };
}

