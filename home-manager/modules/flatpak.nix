{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.testing;
in
{
  imports = [
    "${<nix-flatpak>}/modules/home-manager.nix"
  ];

  options.myHome.flatpak = {
    enable = lib.mkEnableOption "Enable declarative flatpak configuration.";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      packages = [
        "com.github.Matoking.protontricks"
      ];
    };
  };
}
