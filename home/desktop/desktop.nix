{ inputs, username, pkgs, self, ... }:
{
  imports = [
    ./foot
    ./hyprland
    ./waybar
    ./wofi
    ./hyprlock
    ./avizo
    ./mako

    ./freedesktop.nix
    ./gtk.nix
  ];
}
