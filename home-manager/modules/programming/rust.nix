{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.rust;
in
{
  options.myHome.programming.rust = {
    enable = lib.mkOption {
      description = "Enable the Rust programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rustc cargo
    ];
  };
}



