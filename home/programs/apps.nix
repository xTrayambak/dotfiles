{ pkgs, ... }:

{
	imports = [
		./discord
	];
	home.packages = with pkgs; [
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
		gnome-control-center
		# mission-center
		chromium
		blueman
		nautilus
	];
}
