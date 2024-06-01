{ inputs, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.prismlauncher
		pkgs.mangohud
		pkgs.superTuxKart
		pkgs.xonotic
		pkgs.steam
		pkgs.bottles

		inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
	];

	programs.java = {
		enable = true;
		package = pkgs.jdk21;
	};
}
