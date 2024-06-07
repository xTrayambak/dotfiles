{ inputs, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.prismlauncher
		pkgs.mangohud
		pkgs.superTuxKart
		pkgs.xonotic
		pkgs.steam
		pkgs.bottles
	];

	programs.java = {
		enable = true;
		package = pkgs.jdk21;
	};
}
