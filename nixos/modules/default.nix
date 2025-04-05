{ ... }:
{
  imports = [
    ./connections
    ./desktop
    ./virtualization
    ./self-hosted
    ./socials
    ./system
    ./users

    ./ai.nix
    ./base.nix
    ./boot-amd64.nix
    ./college.nix
    ./rax.nix
  ];
}

