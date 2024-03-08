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
    fd
    file
    ani-cli

    zip
    unzip
    htop
    imagemagick_light
  ];
}
