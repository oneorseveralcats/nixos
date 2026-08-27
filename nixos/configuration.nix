{ config, pkgs, ... }:

{
  imports = [
      ./modules
  
      ./profiles/base.nix
  ];

  system.stateVersion = "26.05";
}
