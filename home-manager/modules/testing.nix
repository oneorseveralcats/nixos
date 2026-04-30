{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.testing;
in
{
  imports = [
  ];

  options.myHome.testing = {
    enable = lib.mkEnableOption "Enable packages and settings that are currently being tested.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
