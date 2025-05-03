{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.ruby;
in
{
  options.myHome.programming.languages.ruby = {
    enable = lib.mkEnableOption "Enable the ruby programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ruby rubyPackages.solargraph
    ];
  };
}




