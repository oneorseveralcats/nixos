{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials;
in
{
  imports = [
    ./irssi.nix
    ./signal.nix
    ./telegram.nix
  ];

  options.myHome.socials = {
    enable = lib.mkEnableOption "Enable my standard programs for socializing.";
  };

  config = mkIf cfg.enable {
    myHome.socials = {
      signal.enable = true;
      telegram.enable = true;
    };
  };
}
