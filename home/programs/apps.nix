{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	armcord
	blender
	obs-studio
	keepassxc
	zathura	
	
	gnome.gnome-calculator
	gnome.gnome-characters
	gnome.gnome-control-center
	gnome-usage
        dino
	valent
	headlines
	snapshot
	loupe
	chromium
	gnome.nautilus
  ];
}
