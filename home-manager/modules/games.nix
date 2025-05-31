{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.games;
  cliGames = with pkgs; [
    frotz
    gnugo katago
    nethack
    tty-solitaire
    vitetris
  ];
  kdeGames = with pkgs.kdePackages; [
    kfourinline
    kgeography
    kigo
    knights
    ksudoku
  ];
  retroarchPkg = pkgs.retroarch.withCores (cores: with cores; [
    beetle-psx-hw
    bsnes
    genesis-plus-gx
    melonds
    mesen
    mgba
    mupen64plus
  ]);
in
{
  options.myHome.games = {
    enable = lib.mkOption {
      description = "Enable games.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      ttysolitaire = "${pkgs.tty-solitaire}/bin/ttysolitaire -p 999 --no-background-color";
    };

    home.packages = with pkgs; [
      dolphin-emu-beta
      minetest
      pcsx2 protontricks prismlauncher
      retroarchPkg
      terraria-server
      wine winetricks
    ] ++ cliGames ++ kdeGames;

    home.file.".local/bin/terraria" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        exec steam-run /media/storage/games/gog/Terraria/start.sh
      '';
    };
  };
}
