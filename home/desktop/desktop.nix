{ ... }:
{
  imports = [
    # ./foot
    # ./hyprland
    ./hyprland/hyprlock.nix
    ./waybar
    ./niri
    ./avizo
    ./nitty
    ./wlogout
    ./fuzzel
    ./mako
    ./wezterm

    ./theme.nix
  ];
}
