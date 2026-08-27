{ config, inputs, lib, pkgs, ...}:
{
  imports = [
    "${inputs.nixos-wsl}.modules"
    ../hardware-configuration/wsl.nix

    ../configuration.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "user";
    interop.register = true;
  };

  myConfig = {
    base.enable = true;
    system.doas.enable = true;

    users = {
      root.enable = true;
      user.enable = true;
    };
  };

  boot.loader.systemd-boot.enable = lib.mkForce false;
}
