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
    gnome-secrets
    gnome-control-center
    amberol
    gnome-calendar
    gimp
    tenacity
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
    authenticator
    inputs.nitty.packages.${pkgs.system}.default
  ];
}
