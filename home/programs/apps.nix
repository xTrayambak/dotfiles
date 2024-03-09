{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	armcord
	blender
	obs-studio
	keepassxc
	zathura

	overskride
	fractal
	snapshot
	loupe
	gnome.nautilus
  ];
}
