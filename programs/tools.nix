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
    swww
    cava
    python3
    cmatrix
  ];
}
