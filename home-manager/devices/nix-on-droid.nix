{ config, pkgs, lib, ... }:

{
  myHome = {
    desktop.enable = false;
    books.enable = false;
    gaming.gui.enable = false;
    multimedia.enable = false;
    probation.enable = false;
    rax.enable = false;
    testing.enable = false;
  };

  home.packages = with pkgs; [
  ];
}
