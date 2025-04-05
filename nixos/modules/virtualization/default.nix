{ ... }:
{
  imports = [
    ./docker.nix
    ./libvirt.nix
    ./podman.nix
    ./virtualbox.nix
    ./virtualbox-guest.nix
  ];
}


