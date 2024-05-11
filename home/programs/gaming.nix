{ inputs, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.prismlauncher
		pkgs.mangohud
		pkgs.superTuxKart
		pkgs.xonotic
		pkgs.steam

		inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
	];
}
