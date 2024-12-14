{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.games;
  kdeGames = with pkgs.kdePackages; [
    kfourinline
    kgeography
    kigo
    knights
    ksudoku
  ];
in
{
  options.myHome.games = {
    gui.enable = lib.mkOption {
      description = "Enable gui games.";
      type = types.bool;
      default = true;
    };
    cli.enable = lib.mkOption {
      description = "Enable cli games.";
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf cfg.gui.enable {
      home.packages = with pkgs; [
        dolphin-emu-beta
        minetest
        pcsx2 protontricks prismlauncher
        terraria-server
        wine winetricks

        (retroarch.override {
          cores = with libretro; [
            beetle-psx-hw
            bsnes
            genesis-plus-gx
            melonds
            mesen
            mgba
            mupen64plus
          ];
        })
      ] ++ kdeGames;

      home.file.".local/bin/terraria" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          exec steam-run /media/storage/games/gog/Terraria/start.sh
        '';
      };
    })

    (mkIf cfg.cli.enable {
      home.packages = with pkgs; [
        frotz
        gnugo
        nethack
        tty-solitaire
        vitetris
      ];
    })
  ];
}
