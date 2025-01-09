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

    stylix.targets.helix.enable = true;
    programs.helix.settings.theme = lib.mkForce "stylix-custom";
    programs.helix.themes = {
      stylix-custom = let
        base00 = "#${config.lib.stylix.colors.base00-hex}";
        base01 = "#${config.lib.stylix.colors.base01-hex}";
        base02 = "#${config.lib.stylix.colors.base02-hex}";
        base03 = "#${config.lib.stylix.colors.base03-hex}";
        base04 = "#${config.lib.stylix.colors.base04-hex}";
        base05 = "#${config.lib.stylix.colors.base05-hex}";
        base06 = "#${config.lib.stylix.colors.base06-hex}";
        base07 = "#${config.lib.stylix.colors.base07-hex}";
        base08 = "#${config.lib.stylix.colors.base08-hex}";
        base09 = "#${config.lib.stylix.colors.base09-hex}";
        base0A = "#${config.lib.stylix.colors.base0A-hex}";
        base0B = "#${config.lib.stylix.colors.base0B-hex}";
        base0C = "#${config.lib.stylix.colors.base0C-hex}";
        base0D = "#${config.lib.stylix.colors.base0D-hex}";
        base0E = "#${config.lib.stylix.colors.base0E-hex}";
        base0F = "#${config.lib.stylix.colors.base0F-hex}";
      in {
        "attributes" = base09;
        "comment" = { fg = base03; modifiers = ["italic"]; };
        "constant" = base09;
        "constant.character.escape" = base0C;
        "constant.numeric" = base09;
        "constructor" = base0D;
        "debug" = base03;
        "diagnostic" = { underline.style = "line"; };
        "diff.delta" = base09;
        "diff.minus" = base08;
        "diff.plus" = base0B;
        "error" = base08;
        "function" = base0D;
        "hint" = base03;
        "info" = base0D;
        "keyword" = base0E;
        "label" = base0E;
        "namespace" = base0E;
        "operator" = base05;
        "special" = base0D;
        "string"  = base0B;
        "type" = base0A;
        "variable" = base08;
        "variable.other.member" = base0B;
        "warning" = base09;

        "markup.bold" = { fg = base0A; modifiers = ["bold"]; };
        "markup.heading" = base0D;
        "markup.italic" = { fg = base0E; modifiers = ["italic"]; };
        "markup.link.text" = base08;
        "markup.link.url" = { fg = base09; underline.style = "line"; };
        "markup.list" = base08;
        "markup.quote" = base0C;
        "markup.raw" = base0B;
        "markup.strikethrough" = { modifiers = ["crossed_out"]; };

        "diagnostic.hint" = { underline = { style = "curl"; }; };
        "diagnostic.info" = { underline = { style = "curl"; }; };
        "diagnostic.warning" = { underline = { style = "curl"; }; };
        "diagnostic.error" = { underline = { style = "curl"; }; };

        "ui.background" = { bg = base00; };
        "ui.bufferline.active" = { fg = base00; bg = base0D; modifiers = ["bold"]; }; # Edited
        "ui.bufferline" = { fg = base04; bg = base00; };
        "ui.cursor" = { fg = base0A; modifiers = ["reversed"]; };
        "ui.cursor.insert" = { fg = base0A; modifiers = ["reversed"]; };
        "ui.cursorline.primary" = { fg = base05; bg = base01; };
        "ui.cursor.match" = { fg = base0A; underline.style = "line"; };
        "ui.cursor.primary" = { fg = base0A; modifiers = ["reversed"]; }; # Added
        "ui.cursor.select" = { fg = base0A; modifiers = ["reversed"]; };
        "ui.gutter" = { bg = base00; };
        "ui.help" = { fg = base06; bg = base01; };
        "ui.linenr" = { fg = base03; bg = base00; };
        "ui.linenr.selected" = { fg = base04; bg = base01; modifiers = ["bold"]; };
        "ui.menu" = { fg = base05; bg = base01; };
        "ui.menu.scroll" = { fg = base03; bg = base01; };
        "ui.menu.selected" = { fg = base01; bg = base04; };
        "ui.popup" = { bg = base01; };
        "ui.selection" = { bg = base02; };
        "ui.selection.primary" = { bg = base02; };
        "ui.statusline" = { fg = base04; bg = base01; };
        "ui.statusline.inactive" = { bg = base01; fg = base03; };
        "ui.statusline.insert" = { fg = base00; bg = base0B; };
        "ui.statusline.normal" = { fg = base00; bg = base0D; }; # Modified
        "ui.statusline.select" = { fg = base00; bg = base0F; };
        "ui.text" = base05;
        "ui.text.focus" = base05;
        "ui.virtual.indent-guide" = { fg = base03; };
        "ui.virtual.inlay-hint" = { fg = base03; };
        "ui.virtual.ruler" = { bg = base01; };
        "ui.virtual.jump-label" = { fg = base0A; modifiers = ["bold"]; };
        "ui.window" = { bg = base01; };
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

