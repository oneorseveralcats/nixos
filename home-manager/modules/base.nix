{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.base;
  fonts = with pkgs; [
    corefonts
    mno16
    nerd-fonts.fira-code
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
    myHome.browsers.gemini.enable = true;

    nixpkgs.config.packageOverrides = pkgs: {
      nur = import <nur> { inherit pkgs; };
      unstable = import <nixos-unstable> { inherit pkgs; };
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "corefonts"
      "jflap"
      "libretro-genesis-plus-gx"
      "steam"
      "terraria-server"
      "unrar"
      "video-downloadhelper"
      "zerotierone"
    ];

    home = {
      sessionPath = [
        "$HOME/.appimages"
      ];
      shellAliases = {
        e = "$EDITOR";
        f = "lft";
        ff = "cd $(lf -print-last-dir)";
        mvi = "${pkgs.mpv-unwrapped}/bin/mpv --config-dir=${config.xdg.configHome}/.config/mvi";
        neofetch = "${pkgs.hyfetch}/bin/neowofetch";
        q = "exit";
        weather = "${pkgs.curl}/bin/curl 'wttr.in/Cincinnati?2QFu'";
      };
    };

    xdg.configFile."bluetuith/bluetuith.conf".text = ''
      {
        adapter: ""
        adapter-states: ""
        connect-bdaddr: ""
        gsm-apn: ""
        gsm-number: ""
        no-warning: ""
        keybindings: {
          NavigateDown: j
          NavigateUp: k
        }
        receive-dir: "${config.home.homeDirectory}/downloads"
        theme: {}
      }
    '';


    home.packages = with pkgs; [
      asciinema
      exiftool
      httrack
      imagemagickBig
      magic-wormhole megatools moreutils
      ncdu
      pulsemixer python3Packages.yq
      rdrview 
      termdown
      # ventoy-bin 
      wcalc wget woof 

      distrobox lilipod

      # archives
      atool bzip2 gzip p7zip unrar unzip xz zip

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
