{ config, lib, ... }:
with lib;
let 
  cfg = config.myHome.programming;
in
{
  imports = [
    ./ada.nix
    ./algol.nix
    ./base.nix
    ./c.nix
    ./clojure.nix
    ./cobol.nix
    ./coq.nix
    ./common-lisp.nix
    ./crystal.nix
    ./dotnet.nix
    ./elixir.nix
    ./elm.nix
    ./erlang.nix
    ./fortran.nix
    ./go.nix
    ./haskell.nix
    ./idris.nix
    ./lua.nix
    ./miranda.nix
    ./ocaml.nix
    ./pascal.nix
    ./perl.nix
    ./prolog.nix
    ./purescript.nix
    ./python.nix
    ./ruby.nix
    ./rust.nix
    ./r.nix
    ./scala.nix
    ./scheme.nix
    ./smalltalk.nix
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
        idris.enable = lib.mkDefault true;
        lua.enable = lib.mkDefault true;
        purescript.enable = lib.mkDefault true;
        python.enable = lib.mkDefault true;
        scheme.enable = lib.mkDefault true;
        rust.enable = lib.mkDefault true;
      };
    };
  };
}
