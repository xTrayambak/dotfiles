{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	armcord
	blender
	obs-studio
	keepassxc
	zathura	
	
	gnome.gnome-calculator
	valent
	headlines
	snapshot
	loupe
	chromium
	gnome.nautilus
  ];
}
