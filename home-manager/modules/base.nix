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
    myHome.browsers.gemini.enable = true;

    nixpkgs.config.packageOverrides = pkgs: {
      nur = import <nur> { inherit pkgs; };
      unstable = import <nixos-unstable> { inherit pkgs; };
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "corefonts"
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
        neofetch = "${pkgs.hyfetch}/bin/neowofetch";
        q = "exit";
        weather = "${pkgs.curl}/bin/curl 'wttr.in/Cincinnati?2QFu'";
      };
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
