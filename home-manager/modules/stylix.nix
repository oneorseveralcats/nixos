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
      base16Scheme = {
        name = "OneDark Dark";
        author = "olimorris (https://github.com/olimorris)";
        base00 = "000000";  
        base01 = "1c1f24";  
        base02 = "2c313a";  
        base03 = "434852";  
        base04 = "565c64";  
        base05 = "abb2bf";  
        base06 = "b6bdca";  
        base07 = "c8ccd4";  
        base08 = "ef596f";  
        base09 = "d19a66";  
        base0A = "e5c07b";  
        base0B = "89ca78";  
        base0C = "2bbac5";  
        base0D = "61afef";  
        base0E = "d55fde";  
        base0F = "be5046";  
      };
      
      cursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 30;
      };
      iconTheme = {
        enable = true;
        dark = "Adwaita";
        light = "Adwaita";
        package = pkgs.adwaita-icon-theme;
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
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = 12;
          desktop = 14;
          popups = 12;
          terminal = 16;
        };
      };

      targets = {
        swaylock.useImage = false;
      };
    };

    ## Overrides
    wayland.windowManager.river.settings = {
        # background-color = lib.mkForce "0x002b36";
        # border-color-focused = lib.mkForce "0x${config.stylix.base16Scheme.base0D}";
        border-color-unfocused = lib.mkForce "0x${config.stylix.base16Scheme.base02}";
    };

    wayland.windowManager.sway.config.colors = {
      focused.background = lib.mkForce "#${config.stylix.base16Scheme.base0D}";
      focused.text = lib.mkForce "#${config.stylix.base16Scheme.base00}";
      focusedInactive.border = lib.mkForce "#${config.stylix.base16Scheme.base0D}";
      unfocused.border = lib.mkForce "#${config.stylix.base16Scheme.base02}";
    };

    programs.waybar.style = ''
      .modules-left #workspaces button:hover,
      .modules-left #tags button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      .modules-left #workspaces button,
      .modules-left #tags button {
        color: #${config.stylix.base16Scheme.base05};
        padding: 0 3px;
      }

      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active,
      .modules-left #tags button.focused,
      .modules-left #tags button.active {
        border-bottom-color: #${config.stylix.base16Scheme.base0D};
        color: #${config.stylix.base16Scheme.base0D};
      }

      .modules-left #workspaces button.empty,
      .modules-left #tags button:not(.occupied):not(.focused) {
        color: #${config.stylix.base16Scheme.base02};
      }

      .modules-left widget label#mode {
        margin-left: 0.25em;
        color: #${config.stylix.base16Scheme.base08};
      }

      .modules-right widget {
        border-left: 1.25px solid #${config.stylix.base16Scheme.base05};
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

    programs.fuzzel.settings.colors = rec {
      match = lib.mkForce "${config.stylix.base16Scheme.base0D}ff";
      selection-match = match;
    };

    xresources = {
      properties = {
        "Nsxiv.window.background" =	"#${config.stylix.base16Scheme.base00}";
        "Nsxiv.window.foreground" =	"#${config.stylix.base16Scheme.base0D}";
        "Nsxiv.bar.background" =	"#${config.stylix.base16Scheme.base0D}";
        "Nsxiv.bar.foreground" =	"#${config.stylix.base16Scheme.base00}";
        "Nsxiv.mark.foreground" =	"#${config.stylix.base16Scheme.base08}";
        "Nsxiv.bar.font" = "${config.stylix.fonts.sansSerif.name}-${toString config.stylix.fonts.sizes.applications}";
      };
    };
  };
}

