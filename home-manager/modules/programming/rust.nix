{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.rust;
in
{
  options.myHome.programming.languages.rust = {
    enable = lib.mkEnableOption "Enable the Rust programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rustc cargo
      rust-analyzer
    ];
  };
}



