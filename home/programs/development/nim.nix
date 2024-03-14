{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nim
    nimlsp
    nimble
  ];
}
