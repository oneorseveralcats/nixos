{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming;
in
{
  imports = [
    ./base.nix
    ./c.nix
    ./common-lisp.nix
    ./elm.nix
    ./haskell.nix
    ./lua.nix
    ./purescript.nix
    ./python.nix
    ./rust.nix
    ./r.nix
  ];

  options.myHome.programming = {
    enable = lib.mkOption {
      description = "Enable programming languages and tools.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    myHome.programming = {
      base.enable = lib.mkDefault true;

      languages = {
        c.enable = lib.mkDefault true;
        common-lisp.enable = lib.mkDefault true;
        elm.enable = lib.mkDefault true;
        haskell.enable = lib.mkDefault true;
        lua.enable = lib.mkDefault true;
        purescript.enable = lib.mkDefault true;
        python.enable = lib.mkDefault true;
        rust.enable = lib.mkDefault true;
      };
    };
  };
}
