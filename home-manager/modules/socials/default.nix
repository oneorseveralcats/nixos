{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials;
in
{
  imports = [
    ./irssi.nix
    ./session.nix
    ./signal.nix
    ./telegram.nix
  ];

  options.myHome.socials = {
    enable = lib.mkEnableOption "Enable my standard programs for socializing.";
  };

  config = mkIf cfg.enable {
    myHome.socials = {
      session.enable = true;
      signal.enable = true;
      telegram.enable = true;
    };
  };
}
