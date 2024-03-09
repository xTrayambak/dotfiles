{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cloc
    htop
    ripgrep
    fzf
    jq
    playerctl
    moreutils
    gh
    cava
    python3
    cmatrix
    fd
    file
    mpv
    ani-cli

    zip
    unzip
    htop
    imagemagick_light
  ];
}
