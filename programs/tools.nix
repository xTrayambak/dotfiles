{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cloc
    ripgrep
    fzf
    jq
    playerctl
    moreutils
    gh
    cava
    python3
    cmatrix
    ani-cli

    zip
    unzip
    htop
    imagemagick_light
  ];
}
