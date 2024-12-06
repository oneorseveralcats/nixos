{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.rax;
in
{
  options.myHome.rax = {
    enable = lib.mkOption {
      description = "Enable programs that rax has me install.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zerotierone
    ];
  };
}
