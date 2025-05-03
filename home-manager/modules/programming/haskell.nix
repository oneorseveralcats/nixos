{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.haskell;
in
{
  options.myHome.programming.languages.haskell = {
    enable = lib.mkEnableOption "Enable the Haskell programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.haskellPackages; [
      ghc 
      haskell-language-server ormolu
      brick turtle curlhs language-gemini pandoc 
    ];
  
    home.file.".haskeline".text = ''
      editMode: Vi
    '';
    home.file.".ghci".text = ''
      :set prompt "λ> "
    '';

    programs.helix.languages.language = [
      {
        name = "haskell";
        auto-format = true;
        formatter = { command = "${pkgs.ormolu}/bin/ormolu"; args = [ "--stdin-input-file" "dummy.hs" ]; };
      }
    ];
  };
}
