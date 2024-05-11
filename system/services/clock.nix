{ pkgs, ... }:
{
	services.chrony = {
		enable = true;
		enableNTS = true;
		servers = [ "in.pool.ntp.org" ];
	};
}
