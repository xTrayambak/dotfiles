{ ... }:
{
  imports = [
    # ./foot
    # ./hyprland
    ./hyprland/hyprlock.nix
    ./waybar
    ./niri
    ./avizo
    ./fusuma
    ./nitty
    ./wlogout
    ./fuzzel
    ./mako
    ./wezterm

    ./theme.nix
  ];
}
