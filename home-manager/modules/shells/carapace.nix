{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.carapace;
in
{
  options.myHome.shells.carapace = {
    enable = lib.mkEnableOption "Enable the carapace shell completion library.";
  };

  config = mkIf cfg.enable {
    programs.carapace = {
      enable = true;
    };
  };
}

