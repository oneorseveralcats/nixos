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
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
        size = 36;
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

    stylix.targets.helix.enable = false;
    programs.helix.settings.theme = "stylix";
    programs.helix.themes = {
      stylix = let
        base00 = "#${config.stylix.base16Scheme.base00}";
        base01 = "#${config.stylix.base16Scheme.base01}";
        base02 = "#${config.stylix.base16Scheme.base02}";
        base03 = "#${config.stylix.base16Scheme.base03}";
        base04 = "#${config.stylix.base16Scheme.base04}";
        base05 = "#${config.stylix.base16Scheme.base05}";
        base06 = "#${config.stylix.base16Scheme.base06}";
        base07 = "#${config.stylix.base16Scheme.base07}";
        base08 = "#${config.stylix.base16Scheme.base08}";
        base09 = "#${config.stylix.base16Scheme.base09}";
        base0A = "#${config.stylix.base16Scheme.base0A}";
        base0B = "#${config.stylix.base16Scheme.base0B}";
        base0C = "#${config.stylix.base16Scheme.base0C}";
        base0D = "#${config.stylix.base16Scheme.base0D}";
        base0E = "#${config.stylix.base16Scheme.base0E}";
        base0F = "#${config.stylix.base16Scheme.base0F}";
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
        "ui.bufferline.active" = { fg = base00; bg = base03; modifiers = ["bold"]; };
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

