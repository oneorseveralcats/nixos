{ config, lib, ...}:
{
  imports = [
    ./bars
    ./compositors
    ./others
    ./launchers
    ./terminals

    ./base.nix
    ./extras.nix
    ./testing.nix
  ];
}
