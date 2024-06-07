{
	networking = {
		networkmanager.enable = true;
		hostName = "box";

		nftables.enable = true;
		firewall = {
			enable = true;
			allowedTCPPorts = [ 80 443 8080 1714 ];
			allowedUDPPorts = [ 1714 ];
		};

		nameservers = [ "192.168.68.214" ];
	};
}
