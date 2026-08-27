{ config, inputs, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.base;
in
{
  imports = [
    inputs.flake-programs-sqlite.homeModules.programs-sqlite
  ];

  options.myHome.base = {
    enable = lib.mkEnableOption "Enable the most basic configuration operations and programs.";
  };

  config = mkIf cfg.enable {
    nix = {
      package = pkgs.nix;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
    xdg.configFile."nix/nix.conf".force = true;

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
      just
      magic-wormhole megatools moreutils
      ncdu nix-tree nmap
      pulsemixer python3Packages.yq
      rdrview
      termdown
      # ventoy-bin 
      watchexec wcalc wget

      # terminal powerpoint
      # haskellPackages.patat
    ];

    home.preferXdgDirectories = true;
  
    programs.command-not-found.enable = true;
    programs.jq.enable = true;
    programs.fzf.enable = true;
    services.ssh-agent.enable = true;
    services.syncthing.enable = true;

    xdg = {
      enable = true;
      userDirs = {
        enable = pkgs.stdenv.hostPlatform.isLinux;
        setSessionVariables = true;
        desktop = "${config.home.homeDirectory}/";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = "${config.home.homeDirectory}/audio";
        pictures = "${config.home.homeDirectory}/pictures";
        projects = "${config.home.homeDirectory}/projects";
        videos = "${config.home.homeDirectory}/videos";
      };
    };
  };
}
