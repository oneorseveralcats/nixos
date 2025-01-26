{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.rust;
in
{
  options.myHome.programming.languages.rust = {
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



