{ config, pkgs, ... }:
{
  myConfig.boot-amd6.enable = true;

  networking.hostName = "t470s";
}
