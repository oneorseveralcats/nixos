{ config, lib, pkgs, ... }:
{
  imports = [
    ../hardware-configuration/server.nix

    ../configuration.nix
  ];

  myConfig.connections.nas.enable = lib.mkForce false;

  fileSystems."/media/jellyfin" = {
    device = "/dev/disk/by-uuid/9f615694-c827-4bbc-90d2-53fd912f203f";
    fsType = "ext4";
  };

  fileSystems."/media/nas" = {
    device = "/dev/disk/by-uuid/cc4735c4-76c1-4612-95b9-335fb99b71e5";
    fsType = "ext4";
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.1. localhost";
        "hosts deny" = "ALL";
        "guest account" = "nobody";
      };
      "nas" = {
        "path" = "/media/nas";
        "browseable" = "yes";
        "writeable" = "yes";
        "create mask" = "0644";
        "force user" = "user";
        "valid users" = "user";
      };
    };
  };


  networking.hostName = "server";
}
