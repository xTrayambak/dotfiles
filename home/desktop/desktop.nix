{ inputs, username, pkgs, self, ... }:
{
  imports = [
    ./foot
    ./hyprland
    ./waybar
    ./wofi
    ./avizo
    ./fusuma
    ./mako

    ./gtk.nix
  ];
}
