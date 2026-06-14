{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.localsend;
in
{
  options.myConfig.connections.localsend = {
    enable = lib.mkEnableOption "localsend, an opensource airdrop-like program";
  };

  config = mkIf cfg.enable {
    programs.localsend.enable = true;
  };
}


