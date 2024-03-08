{ inputs, lib, pkgs, ... }:

{
	home.packages = with pkgs; [
		prismlauncher
		mangohud
		superTuxKart
		xonotic
	];
}
