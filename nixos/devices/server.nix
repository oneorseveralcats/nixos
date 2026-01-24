{ config, lib, pkgs, ... }:
{
  imports = [
  ];

  myConfig.boot-amd64.enable = true;
  myConfig.connections.nas.enable = lib.mkForce false;

  fileSystems."/media/jellyfin" = {
    device = "/dev/disk/by-uuid/9f615694-c827-4bbc-90d2-53fd912f203f";
    fsType = "ext4";
  };

  fileSystems."/media/nas" = {
    device = "/dev/disk/by-uuid/cc4735c4-76c1-4612-95b9-335fb99b71e5";
    fsType = "ext4";
  };


  networking.hostName = "server";
}
