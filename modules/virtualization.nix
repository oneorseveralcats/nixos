{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization;
in
{
  options.myConfig.virtualization = {
    enable = lib.mkOption {
      description ="Enable support for QEMU-based virtualization.";
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
    # programs.dconf.enable = true;
  };

}
