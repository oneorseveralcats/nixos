{ config, lib, pkgs, ...}:
{
  imports = [ <nixos-wsl/modules> ];

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
