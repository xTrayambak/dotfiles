{ inputs, username, ... }:
{
  imports = [
    ./foot/default.nix
    ./hyprland/default.nix
    ./mako/default.nix
    ./waybar/default.nix
    ./wofi/default.nix

    ./gtk.nix
  ];
}
