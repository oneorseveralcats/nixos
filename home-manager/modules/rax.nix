{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.rax;
in
{
  options.myHome.rax = {
    enable = lib.mkEnableOption "Enable programs that rax has me install.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zerotierone
    ];
  };
}
