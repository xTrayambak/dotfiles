{
	networking = {
		networkmanager.enable = true;

		nftables.enable = true;
		firewall = {
			enable = true;
			allowedTCPPorts = [ 80 443 8080 ];
		};
	};
}
