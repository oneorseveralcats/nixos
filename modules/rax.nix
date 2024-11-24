{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.rax;
in
{
  options.myConfig.rax = {
    enable = lib.mkOption {
      description = "Enable things that are related to Rax";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zerotierone
    ];

    services.zerotierone = {
      enable = true;
      port = 9993;
      joinNetworks = [
        "272f5eae167f70a1"
      ];
    };
  };
}

