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
    spotube
    gnome-control-center
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
    simple-scan
    mission-center
    smartmontools
    blueman
    nautilus
  ];
}
