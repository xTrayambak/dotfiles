{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	armcord
	blender
	obs-studio
	keepassxc
	zathura	
	
	gnome.gnome-calculator
	overskride
	headlines
	snapshot
	loupe
	gnome.nautilus
  ];
}
