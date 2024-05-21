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
    ./wezterm
    ./mako

    ./gtk.nix
  ];
}
