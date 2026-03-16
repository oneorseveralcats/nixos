{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.games.cli;
in
{
  options.myHome.games.cli = {
    enable = lib.mkEnableOption "Enable selected commandline games.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      frotz
      gnugo
      nethack
      tty-solitaire
      vitetris
    ] ++ lib.optional pkgs.stdenv.hostPlatform.isx86 katago;

    home.shellAliases = {
      ttysolitaire = "${pkgs.tty-solitaire}/bin/ttysolitaire -p 999 --no-background-color";
    };
  };
}
