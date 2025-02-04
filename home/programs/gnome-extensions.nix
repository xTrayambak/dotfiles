{ pkgs, ... }:
{
	home.packages = with pkgs.gnomeExtensions; [
		blur-my-shell
	];
}
