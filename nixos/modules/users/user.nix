{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.users.user;
in
{
  options.myConfig.users.user = {
    enable = lib.mkOption {
      description = "Enable the foundational packages and settings.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    users = {
      users.user = {
        isNormalUser = true;
        extraGroups = [
         "adbusers"
         "docker"
         "keyd" "kvm"
         "libvirtd" "lp"
         "networkmanager"
         "plugdev"
         "scanner"
         "video"
         "wheel"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF3AgrAGuIauOJs9U4MyYz+JeA4CDzyfQFXMYutODpv user"
        ];
      };
    };
  };
}

