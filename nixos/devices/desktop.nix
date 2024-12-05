{ config, pkgs, ... }:
{
  myConfig.boot-amd64.enable = true;

  networking.hostName = "desktop";

  networking.firewall.allowedTCPPorts = [ 4976 7777 28960 ];
  networking.firewall.allowedUDPPorts = [ 28960 ];

  # NVME drive can't wake PC
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  programs.steam.enable = true; 
}
