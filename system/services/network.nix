{
	networking = {
		networkmanager.enable = true;
		hostName = "box";

		nftables.enable = true;
		firewall = {
			enable = true;
			allowedTCPPorts = [ 80 443 ];
			allowedUDPPorts = [ ];
			allowedTCPPortRanges = [ 
				{ from = 1714; to = 1764; } # KDE Connect
			];
			allowedUDPPortRanges = [
				{ from = 1714; to = 1764; } # KDE Connect
			];
		};

		nameservers = [ "192.168.68.214" ];
	};
}
