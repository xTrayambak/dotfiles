{ inputs, username, pkgs, self, ... }:
{
  imports = [
    ./foot
    ./hyprland
    ./waybar
    ./wofi
    ./hyprlock
    ./mako

    ./freedesktop.nix
    ./gtk.nix
  ];
}
