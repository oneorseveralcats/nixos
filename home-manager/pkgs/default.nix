{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
let
  nsxiv-extra = pkgs.callPackage ./nsxiv-extra {};
in {
  home.packages = [
    nsxiv-extra
  ];
}
