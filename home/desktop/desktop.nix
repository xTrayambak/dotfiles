{ inputs, username, pkgs, self, ... }:
{
  imports = [
    ./foot
    ./hyprland
    ./waybar
    ./wofi
    ./avizo
    ./fusuma
    ./eww
    ./mako

    ./gtk.nix
  ];
}
