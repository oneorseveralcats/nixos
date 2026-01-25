{...}:
{
  myConfig = {
    base.enable = true;
    testing.enable = true;

    connections = {
      bluetooth.enable = true;
      firewall.enable = true;
      nas.enable = true;
      networking.enable = true;
      openssh.enable = true;
    };

    system = {
      doas.enable = true;
      flatpak.enable = true;
      keymap.enable = true;
    };

    users = {
      root.enable = true;
      user.enable = true;
    };
  };
}
