{ config, pkgs, ... }:
{
  myConfig.boot-amd64.enable = true;

  networking.hostName = "t470s";
}
