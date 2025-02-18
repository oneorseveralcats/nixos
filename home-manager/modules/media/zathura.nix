{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.zathura;
in
{
  options.myHome.media.zathura = {
    enable = lib.mkEnableOption "Enable and configure the zathura document viewer.";
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        guioptions = "";
        selection-clipboard = "clipboard";
      };
      extraConfig = ''
        unmap [normal] 	   q
        unmap [fullscreen] q
        map [normal]     f     toggle_fullscreen
        map [fullscreen] f     toggle_fullscreen
        map [normal]     u     recolor
        map [fullscreen] u     recolor
        map [normal]     <C-f> follow
        map [fullscreen] <C-f> follow
        map [normal]     <C-q> quit
        map [fullscreen] <C-q> quit

        map [normal]     <Button8> navigate previous
        map [fullscreen] <Button8> navigate previous

        map [normal]     <Button9> navigate next
        map [fullscreen] <Button9> navigate next
      '';
    };
  };
}
