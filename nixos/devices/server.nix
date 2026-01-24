{ config, lib, pkgs, ... }:
{
  imports = [
  ];

  myConfig.boot-amd64.enable = true;
  myConfig.connections.nas.enable = lib.mkForce false;

  networking.hostName = "server";
}
