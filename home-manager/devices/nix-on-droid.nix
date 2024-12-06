{ config, pkgs, lib, ... }:

{
  myHome = {
    desktop.enable = false;
    books.enable = false;
    games.enable = false;
    multimedia.enable = false;
    probation.enable = false;
    rax.enable = false;
    testing.enable = false;
  };

  home.packages = with pkgs; [
  ];
}
