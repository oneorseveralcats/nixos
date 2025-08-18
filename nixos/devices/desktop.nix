{ config, pkgs, ... }:
let ports = [
  7777  # terraria
  3074  # bo/bo2
  21889 # bo2
  27016 # mw3
  28960 # waw
  28961 # waw
  # 4976  #
  ];
in {
  myConfig.boot-amd64.enable = true;

  networking.hostName = "desktop";

  networking.firewall.allowedTCPPorts = [] ++ ports;
  networking.firewall.allowedUDPPorts = [] ++ ports;

  # NVME drive can't wake PC
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  programs.steam.enable = true; 
}
