{ lib, ...}:
{
  myHome.programming = {
    base.enable = lib.mkDefault true;

    languages = {
      c.enable = lib.mkDefault true;
      common-lisp.enable = lib.mkDefault true;
      haskell.enable = lib.mkDefault true;
      idris.enable = lib.mkDefault true;
      lua.enable = lib.mkDefault true;
      python.enable = lib.mkDefault true;
      scheme.enable = lib.mkDefault true;
      rust.enable = lib.mkDefault true;
    };
  };
}
