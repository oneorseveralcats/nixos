{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.libvirt;
in
{
  options.myConfig.virtualization.libvirt = {
    enable = lib.mkEnableOption "Enable libvirt and virt-manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    # TODO: replace this with more granular control: https://wiki.nixos.org/wiki/Networking#Virtualization
    networking.firewall.trustedInterfaces = [ "virbr0" ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [ pkgs.virtiofsd ];
      };
      spiceUSBRedirection.enable = true;
    };
  };

}

