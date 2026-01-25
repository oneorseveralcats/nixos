{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.users.user;
in
{
  options.myConfig.users.user = {
    enable = lib.mkEnableOption "Enable regular admin user, groups, and ssh key login for them.";
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
         "vboxusers" "video"
         "wheel"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF3AgrAGuIauOJs9U4MyYz+JeA4CDzyfQFXMYutODpv user"
        ];
      };
    };
  };
}

