{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.openssh;
in
{
  options.myConfig.connections.openssh = {
    enable = lib.mkOption {
      description = "Enable openssh";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}


