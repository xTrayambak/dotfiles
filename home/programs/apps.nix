{ pkgs, ... }:

{
	home.packages = with pkgs; [
		(vesktop.override { withSystemVencord = false; })
		blender
		obs-studio
		zathura	
		gnome-calculator
		gnome-secrets
		gnome.gnome-characters
		gnome.gnome-control-center
		gnome-calendar
		pavucontrol
		valent
		snapshot
		loupe
		duf
		godot_4
		amdgpu_top
		qbittorrent
		kcachegrind
		mission-center
		chromium
		blueman
		nautilus
	];
}
