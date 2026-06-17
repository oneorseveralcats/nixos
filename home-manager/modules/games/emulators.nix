{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.games.emulators;
in
{
  options.myHome.games.emulators = {
    enable = lib.mkEnableOption "Enable selected emulators.";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePackages = [
      "libretro-genesis-plus-gx"
    ];

    home.packages = with pkgs; [
      dolphin-emu
      pcsx2
    ];

    programs.retroarch = {
      enable = true;
      cores = {
        beetle-psx-hw.enable = true;
        bsnes.enable = true;
        genesis-plus-gx.enable = true;
        melonds.enable = true;
        mesen.enable = true;
        mgba.enable = true;
        mupen64plus.enable = true;
      };
      #settings = {
      #  menu_swap_ok_cancel_buttons = "true";
      #};
    };
  };
}
