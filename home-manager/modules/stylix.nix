{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.stylix;
  stylix = import <stylix>;
in
{
  imports = [ stylix.homeManagerModules.stylix ];

  options.myHome.stylix = {
    enable = lib.mkOption {
      description = "Enable stylix, a project to uniformly style NixOS.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      image = lib.mkDefault "${pkgs.lxqt.lxqt-themes}/share/lxqt/wallpapers/origami-dark.png";
      imageScalingMode = lib.mkDefault "fit";
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
        base08 = "#f5708a";
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
      iconTheme = {
        enable = true;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };

      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = config.stylix.fonts.sansSerif.name;
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans Light";
        };
        monospace = {
          package = pkgs.fira-code-nerdfont;
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
        gtk.extraCss = ''
          window.background { border-radius: 0; }
        '';
        swaylock.useImage = false;
      };
    };

    ## Overrides
    # gtk = {
    #   iconTheme = {
    #     package = pkgs.adwaita-icon-theme;
    #     name = "Adwaita";
    #   };
    #   theme = {
    #     package = lib.mkForce pkgs.gnome-themes-extra;
    #     name = lib.mkForce "Adwaita-dark";
    #   };
    # };
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        # package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };

    wayland.windowManager.river.settings = {
        # background-color = lib.mkForce "0x002b36";
        # border-color-focused = lib.mkForce "0x${config.lib.stylix.colors.base0D-hex}";
        border-color-unfocused = lib.mkForce "0x${config.lib.stylix.colors.base02-hex}";
    };

    wayland.windowManager.sway.config.colors = {
      focused.background = lib.mkForce "#${config.lib.stylix.colors.base0D-hex}";
      focused.text = lib.mkForce "#${config.lib.stylix.colors.base00-hex}";
      focusedInactive.border = lib.mkForce "#${config.lib.stylix.colors.base0D-hex}";
      unfocused.border = lib.mkForce "#${config.lib.stylix.colors.base02-hex}";
    };

    programs.waybar.style = ''
      .modules-left #workspaces button:hover,
      .modules-left #tags button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      .modules-left #workspaces button,
      .modules-left #tags button {
        color: @base05;
        padding: 0 3px;
      }

      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active,
      .modules-left #tags button.focused,
      .modules-left #tags button.active {
        border-bottom-color: @base0D;
        color: @base0D;
      }

      .modules-left #workspaces button.empty,
      .modules-left #tags button:not(.occupied):not(.focused) {
        color: @base02;
      }

      .modules-left #workspaces label {
        font-weight: normal;
      }

      .modules-left widget label#mode {
        margin-left: 0.25em;
        color: @base08;
      }

      .modules-right widget {
        border-left: 1.25px solid @base05;
        border-bottom: 15px solid transparent;
        border-top: 15px solid transparent;
        padding-left: 5px;
        padding-right: 5px;
      }

      .modules-right box#tray widget {
        border-left: 0;
      }

      .modules-right box#tray {
        padding-left: 5px;
      }

      .modules-right #custom-sep {
        font-weight: bold;
        padding-left: 2px;
        padding-right: 2px;
      }
    '';

    programs.helix = {
      settings.theme = lib.mkForce "stylix-custom";
      themes = {
        stylix-custom = {
          inherits = "stylix";

          "ui.statusline.normal" = { fg = "base00"; bg = "base0D"; };
          "ui.bufferline.active" = { fg = "base00"; bg = "base0D"; modifiers = ["bold"]; };
          "ui.cursor.primary" = { fg = "base0D"; modifiers = ["reversed"]; };
          "ui.cursor.match" = { fg = "base0D"; underline.style = "line"; };
          # "ui.cursor.select" = { fg = "base0A"; modifiers = ["reversed"]; };
        };
      };
    };

    programs.fuzzel.settings = {
      main.icon-theme = "${config.stylix.iconTheme.dark}";
      colors = rec {
        match = lib.mkForce "${config.lib.stylix.colors.base0D-hex}ff";
        selection-match = match;
      };
    };

    xresources = {
      properties = {
        "Nsxiv.window.background" =	"#${config.lib.stylix.colors.base00-hex}";
        "Nsxiv.window.foreground" =	"#${config.lib.stylix.colors.base0D-hex}";
        "Nsxiv.bar.background" =	"#${config.lib.stylix.colors.base0D-hex}";
        "Nsxiv.bar.foreground" =	"#${config.lib.stylix.colors.base00-hex}";
        "Nsxiv.mark.foreground" =	"#${config.lib.stylix.colors.base08-hex}";
        "Nsxiv.bar.font" = "${config.stylix.fonts.sansSerif.name}-${toString config.stylix.fonts.sizes.applications}";
      };
    };
  };
}

