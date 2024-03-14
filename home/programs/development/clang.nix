{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
	gcc
	libclang
  ];
}
