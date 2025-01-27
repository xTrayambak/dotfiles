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
    git
    hyperfine
    python3
    arp-scan
    meson
    ninja
    cmatrix
    fd
    file
    ngrok
    mpv
    ani-cli

    zip
    unzip
    htop
    imagemagick_light
    senpai
  ];
}
