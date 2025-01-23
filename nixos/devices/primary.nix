{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t470s>
  ];

  networking.hostName = "primary";

  networking.firewall = {
    allowedTCPPorts = [ 9090 ];
    allowedUDPPorts = [];
    # allowedTCPPortRanges = [
    #   { from = 1714; to = 1764; }
    # ];
    # allowedUDPPortRanges = [
    #   { from = 1714; to = 1764; }
    # ];
  };

  myConfig.boot-amd64 = {
    enable = true;
    encryptedBoot = true;
  };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/fa86d9d0-658a-4c43-b3a9-0fdf938c7460";

  programs.kdeconnect.enable = true;
  services.mullvad-vpn.enable = true;
}
