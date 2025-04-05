{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.doas;
in
{
  options.myConfig.system.doas = {
    enable = mkOption {
      description = "Replace sudo with doas.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      doas-sudo-shim
    ];

    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [
          { groups = [ "wheel" ]; persist = true; keepEnv = true; }
        ];
      };
    };
  };
}

