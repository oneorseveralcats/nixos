{ config, pkgs, ... }:
{
  imports = [
    ../profiles/desktop.nix
  ];

  networking.hostName = "labtop";

  networking.firewall.allowedTCPPorts = [ 9090 ];
  networking.firewall.allowedUDPPorts = [];

  myConfig.boot-amd64 = {
    enable = true;
    encryptedBoot = true;
  };
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/796211d7-8756-41ef-b486-fc50b6ca4b61";

  services.mullvad-vpn.enable = true;
}
