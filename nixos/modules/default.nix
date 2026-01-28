{ ... }:
{
  imports = [
    ./connections
    ./desktop
    ./virtualization
    ./self-hosted
    ./socials
    ./sops
    ./system
    ./users

    ./ai.nix
    ./base.nix
    ./rax.nix
    ./testing.nix
  ];
}

