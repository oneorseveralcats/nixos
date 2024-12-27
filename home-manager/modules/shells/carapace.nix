{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.carapace;
in
{
  options.myHome.shells.carapace = {
    enable = lib.mkOption {
      description = "Enable the carapace shell completion library.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.carapace = {
      enable = true;
    };
  };
}

