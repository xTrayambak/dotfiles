{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    libclang
    gdb
    lldb
    libllvm
    just
    meson
    gnumake
    pkg-config
    valgrind
    lld
  ];
}
