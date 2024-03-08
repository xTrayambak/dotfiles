# System chores that must be performed by it regularly
{ pkgs, lib, ... }:
{
	nix.gc = {
		automatic = true;
		dates = "48hr";
		options = "--delete-older-than 3d";
	};

	services.fwupd.enable = true;
}
