{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.stylix;
  stylix = builtins.fetchGit {
    url = "https://github.com/danth/stylix";
    ref = "release-24.11";
    rev = "9015d5d0d5d100f849129c43d257b827d300b089";
    # hash = "sha256-fp1iV2JldCSvz+7ODzXYUkQ+H7zyiWw5E0MQ4ILC4vw=";
  };
in
{
  imports = [ (import stylix).homeManagerModules.stylix ];

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
      base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";
      # base16Scheme = {
      #   name = "OneDark Dark";
      #   author = "olimorris (https://github.com/olimorris)";
      #   base00 = "000000";  
      #   base01 = "1c1f24";  
      #   base02 = "2c313a";  
      #   base03 = "434852";  
      #   base04 = "565c64";  
      #   base05 = "abb2bf";  
      #   base06 = "b6bdca";  
      #   base07 = "c8ccd4";  
      #   base08 = "ef596f";  
      #   base09 = "d19a66";  
      #   base0A = "e5c07b";  
      #   base0B = "89ca78";  
      #   base0C = "2bbac5";  
      #   base0D = "61afef";  
      #   base0E = "d55fde";  
      #   base0F = "be5046";  
      # };
      
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
          # name = "Noto Serif Light";
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
    gtk = {
    #   iconTheme = {
    #     package = pkgs.adwaita-icon-theme;
    #     name = "Adwaita";
    #   };
      theme = {
        package = lib.mkForce pkgs.gnome-themes-extra;
        name = lib.mkForce "Adwaita-dark";
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
        color: #${config.lib.stylix.colors.base05-hex};
        padding: 0 3px;
      }

      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active,
      .modules-left #tags button.focused,
      .modules-left #tags button.active {
        border-bottom-color: #${config.lib.stylix.colors.base0D-hex};
        color: #${config.lib.stylix.colors.base0D-hex};
      }

      .modules-left #workspaces button.empty,
      .modules-left #tags button:not(.occupied):not(.focused) {
        color: #${config.lib.stylix.colors.base02-hex};
      }

      .modules-left widget label#mode {
        margin-left: 0.25em;
        color: #${config.lib.stylix.colors.base08-hex};
      }

      .modules-right widget {
        border-left: 1.25px solid #${config.lib.stylix.colors.base05-hex};
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

