{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.libvirt;
in
{
  options.myConfig.virtualization.libvirt = {
    enable = lib.mkOption {
      description = "Enable libvirt and virt-manager";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    virtualisation = {
      libvirtd.enable = true;
    };
  };

}

