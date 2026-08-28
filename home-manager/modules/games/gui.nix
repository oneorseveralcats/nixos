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
      moonlight-qt
      unstable.protontricks
      terraria-server
      wineWow64Packages.waylandFull unstable.winetricks

      # prismlauncher

      # kde games
      # kdePackages.kfourinline
      # kdePackages.kgeography
      # kdePackages.kigo
      # kdePackages.knights
      # kdePackages.ksudoku
    ];
  };
}
