{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.openssh;
in
{
  options.myConfig.connections.openssh = {
    enable = lib.mkEnableOption "Enable openssh";
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


