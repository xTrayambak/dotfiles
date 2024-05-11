# System chores that must be performed by it regularly
{ pkgs, lib, ... }:
{
	services.fwupd.enable = true;
}
