{ config, lib, ...}:
{
  imports = [
    ./bars
    ./compositors
    ./others
    ./launchers
    ./terminals

    ./autostart.nix
    ./base.nix
    ./extras.nix
    ./testing.nix
  ];
}
