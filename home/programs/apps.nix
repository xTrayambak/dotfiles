{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  	vesktop
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
