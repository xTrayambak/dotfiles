{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    libclang
    gdb
    just
    meson
    gnumake
    pkg-config
    valgrind
    lld
  ];
}
