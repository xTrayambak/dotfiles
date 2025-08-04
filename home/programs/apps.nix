{ pkgs, ... }:

{
  imports = [
    ./discord
  ];
  home.packages = with pkgs; [
    blender
    obs-studio
    zathura
    gnome-calculator
    gnome-secrets
    amberol
    gnome-calendar
    pavucontrol
    snapshot
    loupe
    duf
    godot_4
    amdgpu_top
    pixelorama
    fractal
    libreoffice
    fragments
    mission-center
    smartmontools
    blueman
    nautilus
  ];
}
