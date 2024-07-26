{ pkgs, ... }:

{
  home.packages = with pkgs; [
  	(vesktop.override { withSystemVencord = false; })
	blender
	obs-studio
	zathura	
	
	gnome.gnome-calculator
	gnome-secrets
	gnome.gnome-characters
	gnome.gnome-control-center
	gnome.gnome-calendar
        dino
	valent
	snapshot
	loupe
	godot_4
	chromium
	qbittorrent
	kcachegrind
	mission-center
	blueman
	gnome.nautilus
  ];
}
