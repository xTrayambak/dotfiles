{ pkgs, inputs, ... }:

{
  imports = [
    ./discord
  ];
  home.packages = with pkgs; [
    ghidra-bin
    gimp
    jadx
    duf
    inputs.nitty.packages.${pkgs.system}.default
  ];
}
