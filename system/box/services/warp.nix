{ pkgs, ... }:
{
	services.cloudflare-warp.enable = true;
	systemd.tmpfiles.rules = [
		"L+ /usr/share/warp - - - - ${pkgs.cloudflare-warp}/share/warp"
	];
}
