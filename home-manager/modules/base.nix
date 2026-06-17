{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.base;
  npinsPaths = lib.mapAttrsToList (
    k: v: lib.optionalString (lib.isAttrs v) "${k}=${v}"
  ) (import ../../npins);
  fonts = with pkgs; [
    corefonts
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-cjk-sans
    twemoji-color-font
  ];
in
{
  options.myHome.base = {
    enable = lib.mkEnableOption "Enable the most basic configuration operations and programs.";
  };

  config = mkIf cfg.enable {
    nix = {
      package = pkgs.nix;
      keepOldNixPath = false;
      nixPath = npinsPaths;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
    xdg.configFile."nix/nix.conf".force = true;

    nixpkgs.config.packageOverrides = pkgs: {
      master = import <nixpkgs-master> { inherit pkgs; };
      nur = import <nur> { inherit pkgs; };
      unstable = import <nixpkgs-unstable> { inherit pkgs; };
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "corefonts"
      "jflap"
      "libretro-genesis-plus-gx"
      "steam"
      "terraria-server"
      "video-downloadhelper"
      "zerotierone"
    ];

    home = {
      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.appimages"
      ];
      sessionVariables = {
        TERMINAL = lib.mkDefault "foot";
      };
      shellAliases = {
        e = "$EDITOR";
        q = "exit";
        weather = "${pkgs.curl}/bin/curl 'wttr.in/Cincinnati?2QFu'";
      };
    };

    home.packages = with pkgs; [
      android-tools
      dconf
      exiftool
      ffmpeg
      glow
      httrack
      imagemagickBig
      magic-wormhole megatools moreutils
      ncdu nix-tree nmap npins
      pulsemixer python3Packages.yq
      rdrview
      termdown
      # ventoy-bin 
      watchexec wcalc wget

      # terminal powerpoint
      # haskellPackages.patat
    ] ++ fonts;

    home.preferXdgDirectories = true;
  
    programs.command-not-found = {
      enable = lib.mkDefault true;
      dbPath = "${builtins.storePath pkgs.path}/programs.sqlite";
    };
    programs.jq.enable = lib.mkDefault true;
    programs.fzf.enable = lib.mkDefault true;
    services.ssh-agent.enable = lib.mkDefault true;
    services.syncthing.enable = lib.mkDefault true;

    programs.lesspipe.enable = lib.mkDefault true;
    # home.file.".local/bin/lessfilter".source = pkgs.writeShellScript "lessfilter" ''
    #   if [[ $1 =~ .*(<html|<body>|<head>).* ]]; then
    #     cat "$1"
    #     exit 0
    #   else
    #     exit 1
    #   fi
    # '';

    programs.nix-index = {
      enable = lib.mkDefault true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableNushellIntegration = false;
      enableZshIntegration = false;
    };

    xdg = {
      enable = true;
      userDirs = {
        enable = pkgs.stdenv.hostPlatform.isLinux;
        setSessionVariables = true;
        desktop = "${config.home.homeDirectory}/";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        pictures = "${config.home.homeDirectory}/pictures";
        videos = "${config.home.homeDirectory}/videos";
      };
    };
  };
}
