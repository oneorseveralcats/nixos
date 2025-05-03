{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.nushell;
in
{
  options.myHome.shells.nushell = {
    enable = lib.mkEnableOption "Enable the Nushell.";
  };

  config = mkIf cfg.enable {
    myHome.shells.carapace.enable = true;

    programs.nushell = {
      enable = true;
      # configFile.text = ''
      # '';
      # envFile.txt = ''
      # '';
    };
  };
}
