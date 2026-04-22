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
    zig
    gnumake
    pkg-config
    valgrind
    lld
  ];
}
