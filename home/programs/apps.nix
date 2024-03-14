{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	armcord
	blender
	obs-studio
	keepassxc
	zathura

	overskride
	snapshot
	loupe
	gnome.nautilus
  ];
}
