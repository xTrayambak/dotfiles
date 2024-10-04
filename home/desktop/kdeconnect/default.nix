{ pkgs, lib, ... }:
{
	services.kdeconnect = {
		enable = true;
		package = lib.mkForce pkgs.kdeconnect;
		indicator = true;
	};
}
