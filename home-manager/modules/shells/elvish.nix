{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.elvish;
in
{
  options.myHome.shells.elvish = {
    enable = lib.mkOption {
      description = "Enable the elvish.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      elvish
    ];
    # programs.elvish = {
    #   enable = true;
    # };
  };
}
