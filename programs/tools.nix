{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cloc
    ripgrep
    fzf
    jq
    btop
    playerctl
    moreutils
    gh
  ];
}
