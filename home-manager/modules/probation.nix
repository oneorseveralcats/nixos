{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.probation;
in
{
  options.myHome.probation = {
    enable = lib.mkOption {
      description = "Enable applications that I intend to remove.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {

  };
}
