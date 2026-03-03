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
        # "com.calibre_ebook.calibre" # until nixos fixes calibre tts: https://github.com/NixOS/nixpkgs/issues/364086
        "com.github.Matoking.protontricks"
        "dev.vencord.Vesktop"
      ];
    };
  };
}
