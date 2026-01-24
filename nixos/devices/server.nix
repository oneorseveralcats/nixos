{ config, pkgs, ... }:
{
  imports = [
  ];

  myConfig.boot-amd64.enable = true;

  networking.hostName = "server";
}
