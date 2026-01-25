{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.games.gui;
in
{
  options.myHome.games.gui = {
    enable = lib.mkEnableOption "Enable selected gui games.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      luanti
      protontricks prismlauncher
      terraria-server
      wine winetricks

      
      # kde games
      kdePackages.kfourinline
      kdePackages.kgeography
      kdePackages.kigo
      kdePackages.knights
      kdePackages.ksudoku
    ];
  };
}
