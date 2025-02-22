{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t470s>
  ];

  myConfig.boot-amd64.enable = true;

  networking.hostName = "t470s";
}
