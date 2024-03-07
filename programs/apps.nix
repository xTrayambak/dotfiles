{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	armcord
  ];
}
