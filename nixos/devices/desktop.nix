{ config, pkgs, ... }:
let ports = [
  7777  # terraria
  3074  # bo/bo2
  4976  # bo2 server
  27016 # mw3 server
  28960 # waw
  28961 # waw
  ];
in {
  imports = [
    ../hardware-configuration/desktop.nix

    ../configuration.nix

    ../profiles/ai.nix    
    ../profiles/desktop.nix
    ../profiles/games.nix
    ../profiles/print_scan.nix
    ../profiles/virtualization.nix
  ];

  myConfig.connections.sunshine.enable = true;

  networking.hostName = "desktop";

  networking.firewall.allowedTCPPorts = [] ++ ports;
  networking.firewall.allowedUDPPorts = [] ++ ports;

  # NVME drive can't wake PC
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';
}
