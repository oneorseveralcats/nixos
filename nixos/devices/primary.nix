{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t470s>

    ../profiles/ai.nix
    ../profiles/desktop.nix
    ../profiles/games.nix
    ../profiles/print_scan.nix
    ../profiles/virtualization.nix
  ];

  # 3rd party keyboard trackpoint device ID
  hardware.trackpoint = {
    enable = true;
    device = "PS/2 Generic Mouse";
    sensitivity = 255;
    speed = 255;
  };

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

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/fa86d9d0-658a-4c43-b3a9-0fdf938c7460";
    preLVM = true;
  };
  
  myConfig.connections.vpns.proton.enable = true;
  myConfig.system.lanzaboote.enable = true;
}
