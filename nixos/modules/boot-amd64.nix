{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.boot-amd64;
in
{
  options.myConfig.boot-amd64 = {
    enable = lib.mkEnableOption "Enable for GRUB bootloader on amd64 devices.";
    encryptedBoot = mkEnableOption ''Enable if the device uses grub and has an encrypted root partition. Make sure to set "boot.initrd.luks.devices."root".device".'';
  };

  config = mkMerge [
    (mkIf cfg.enable {
      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
        grub = {
          enable = true;
          device = "nodev";
          useOSProber = true;
          efiSupport = true;
          efiInstallAsRemovable = false;
        };
      };
    })   

    (mkIf cfg.encryptedBoot {
      boot.loader.grub.enableCryptodisk = true;
      boot.initrd = {
        luks.devices."root" = {
          preLVM = true;
          keyFile = "/encrypted_lvm";
        };
        secrets = {
          "/encrypted_lvm" = "/etc/secrets/encrypted_lvm";
        };
      };
    })
  ];
}

