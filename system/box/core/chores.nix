# System chores that must be performed by it regularly
{ ... }:
{
	services.fwupd.enable = true;

	nix.optimise = {
		automatic = true;
		dates = [ "18:30" ];
	};
}
