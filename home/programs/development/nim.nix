{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.nim-unwrapped
    pkgs.nph
    pkgs.nimlsp
    pkgs.nimble
    inputs.atlas.packages.${pkgs.system}.default
  ];
}
