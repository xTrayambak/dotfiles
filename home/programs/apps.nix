{ pkgs, inputs, ... }:

{
  imports = [
    ./discord
  ];
  home.packages = with pkgs; [
    blender
    obs-studio
    zathura
    gnome-calculator
    wireshark
    ghidra-bin
    spotify
    spotifycli
    gnome-secrets
    gnome-control-center
    amberol
    gnome-calendar
    awww
    networkmanagerapplet
    gimp
    tenacity
    pavucontrol
    snapshot
    loupe
    duf
    nocturne
    godot_4
    amdgpu_top
    pixelorama
    fractal
    libreoffice
    fragments
    simple-scan
    mission-center
    smartmontools
    nautilus
    authenticator
  ];
}
