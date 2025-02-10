{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.base;
  fonts = with pkgs; [
    corefonts
    fira-code-nerdfont
    mno16
    noto-fonts
    noto-fonts-cjk-sans
    spleen
    twemoji-color-font
  ];
in
{
  options.myHome.base = {
    enable = lib.mkOption {
      description = "Enable the most basic configuration operations and programs.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "corefonts"
      "libretro-genesis-plus-gx"
      "steam" "steam-original" "steam-run"
      "terraria-server"
      "unrar"
      "zerotierone"
    ];

    home = {
      sessionPath = [
        "$HOME/.appimages"
      ];
      sessionVariables = {
        background = "000000";
        foreground = "ffffff";

        selectionBackground = "3c3c3c";
        selectionForeground = "ffffff";

        black   = "000000";
        red     = "ff8059";
        green   = "44bc44";
        yellow  = "d0bc00";
        blue    = "2fafff";
        magenta = "feacd0";
        cyan    = "00d3d0";
        white   = "bfbfbf";

        brightBlack   = "595959";
        brightRed     = "ef8b50";
        brightGreen   = "70b900";
        brightYellow  = "c0c530";
        brightBlue    = "79a8ff";
        brightMagenta = "b6a0ff";
        brightCyan    = "6ae4b9";
        brightWhite   = "ffffff";
      };
    };

    home.shellAliases = {
      e = "$EDITOR";
      f = "lf";
      nn = "gd";
      neofetch = "${pkgs.hyfetch}/bin/neowofetch";
      q = "exit";
      weather = "${pkgs.curl}/bin/curl 'wttr.in/Cincinnati?2QFu'";
    };

    home.packages = with pkgs; [
      amfora asciinema
      python3Packages.aria2p 
      exiftool
      httrack
      imagemagickBig
      magic-wormhole megatools mpvc
      ncdu
      pulsemixer python3Packages.yq
      rdrview 
      termdown
      ventoy-bin 
      wcalc wget woof 

      distrobox lilipod

      # archives
      atool bzip2 gzip p7zip unrar unzip xz zip

      # lf
      moreutils

      # terminal powerpoint
      haskellPackages.patat
    ] ++ fonts;

    home.preferXdgDirectories = true;

    fonts.fontconfig = {
      # enable = true; disabled because of stylix
      defaultFonts = {
          serif = [ "Noto Serif Light" "Noto Serif" ];
          sansSerif = [ "Noto Sans Light" "Noto Sans" ];
          monospace = [ "Fira Code Nerd Font Light" "Fira Code Light" "Noto Sans Mono" ];
          emoji = [ "Twitter Color Emoji" ];
      };
    };
  
    programs.lesspipe.enable = lib.mkDefault true;
    programs.jq.enable = lib.mkDefault true;
    programs.fzf.enable = lib.mkDefault true;
    services.syncthing.enable = lib.mkDefault true;

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        desktop = "$HOME/";
        documents = "$HOME/documents";
        download = "$HOME/downloads";
        pictures = "$HOME/pictures";
        videos = "$HOME/videos";
      };
    };
  };
}
