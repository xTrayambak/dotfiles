{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.nim-unwrapped-2
    pkgs.nph
    pkgs.nimlsp
    pkgs.nimble
    inputs.atlas.packages.${pkgs.system}.default
  ];
}
