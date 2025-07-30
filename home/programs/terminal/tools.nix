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
    python314
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

    stegseek
    exiftool
    binwalk
    steghide
    zsteg
  ];
}
