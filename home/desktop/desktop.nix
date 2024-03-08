{ inputs, username, pkgs, self, ... }:
{
  imports = [
    ./foot/default.nix
    ./hyprland/default.nix
    ./mako/default.nix
    ./waybar/default.nix
    ./wofi/default.nix
    ./hyprlock/default.nix

    ./freedesktop.nix
    ./gtk.nix
  ];
}
