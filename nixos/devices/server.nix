{ config, lib, pkgs, ... }:
{
  imports = [
  ];

  myConfig.boot-amd64.enable = true;
  myConfig.connections.nas = lib.mkForce false;

  networking.hostName = "server";
}
