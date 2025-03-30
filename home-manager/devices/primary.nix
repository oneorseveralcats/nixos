{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/wayland.nix
  ];

  home.packages = with pkgs; [
  ];

  myHome = {
    socials.enable = true;
  };
}
