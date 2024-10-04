{ pkgs, ... }:

{
	home.packages = with pkgs; [
		(vesktop.override { withSystemVencord = false; })
		blender
		obs-studio
		zathura	
		gnome-calculator
		gnome-secrets
		gnome-calendar
		pavucontrol
		snapshot
		loupe
		duf
		godot_4
		amdgpu_top
		libreoffice
		qbittorrent
		kcachegrind
		mission-center
		chromium
		blueman
		nautilus
	];
}
