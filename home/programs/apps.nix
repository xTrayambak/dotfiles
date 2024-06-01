{ inputs, lib, pkgs, ... }:

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
        dino
	valent
	headlines
	snapshot
	loupe
	chromium
	protonvpn-cli_2
	gnome.nautilus
  ];
}
