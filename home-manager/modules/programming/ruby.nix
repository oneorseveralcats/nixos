{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.ruby;
in
{
  options.myHome.programming.languages.ruby = {
    enable = lib.mkOption {
      description = "Enable the ruby programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ruby rubyPackages.solargraph
    ];
  };
}




