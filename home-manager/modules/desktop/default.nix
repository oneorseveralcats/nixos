{ config, lib, ...}:
{
  imports = [
    ./terminals
    ./compositors

    ./base.nix
    ./extras.nix
  ];
}
