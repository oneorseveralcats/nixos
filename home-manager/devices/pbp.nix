{ config, pkgs, lib, ... }:

{
  imports = [
    ../home.nix

    ../profiles/wayland.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    firefox
  ];

  programs.i3status.modules = {
    "battery all".enable = false;
    "battery 2015" = {
      position = 3;
      settings = {
        path = "/sys/class/power_supply/cw%d-battery/uevent";
        format = "%percentage|";
        integer_battery_capacity = true;
        last_full_capacity = true;
      };
    };
  };
}
