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
    ./csharp.nix
    ./d.nix
    ./elixir.nix
    ./elm.nix
    ./erlang.nix
    ./fennel.nix
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
    ./racket.nix
    ./ruby.nix
    ./rust.nix
    ./r.nix
    ./scala.nix
    ./scheme.nix
    ./smalltalk.nix
    ./zig.nix
  ];
}
