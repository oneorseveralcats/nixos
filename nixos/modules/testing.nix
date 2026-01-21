{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.testing;
in
{
  options.myConfig.testing = {
    enable = lib.mkOption {
      description = "Enable packages and modules that i am testing.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];

    myConfig.virtualization.virtualbox.enable = true;
  };
}

